import { useState } from "react";
import { supabase } from "../supabase";

export default function WaitlistForm({ isBottomCta = false }) {
  const [email, setEmail] = useState("");
  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState("");

  const sendEmail = async (email) => {
    try {
      const response = await fetch(
        `${import.meta.env.VITE_SUPABASE_URL}/functions/v1/send-waitlist-email`,
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ email }),
        }
      );

      if (!response.ok) {
        throw new Error(`Email service returned status ${response.status}`);
      }

      const result = await response.json();

      if (result.error) {
        throw new Error(result.error);
      }

      return { success: true };
    } catch (error) {
      return { success: false, error: error.message };
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (!email) {
      setMessage("Please enter your email");
      return;
    }

    setLoading(true);
    setMessage("");

    try {
      const { error } = await supabase.from("waitlist").insert([{ email }]);

      if (error) {
        if (error.code === "23505") {
          setMessage("This email is already on the waitlist!");
        } else {
          setMessage("Error joining waitlist. Please try again.");
        }
      } else {
        const emailResult = await sendEmail(email);

        if (emailResult.success) {
          setMessage("Successfully added to waitlist! 🎉");
          setEmail("");
        } else {
          console.error("Email sending failed:", emailResult.error);
          setMessage(
            "Added to waitlist, but failed to send confirmation email. Please try again."
          );
        }
      }
    } catch {
      setMessage("Something went wrong. Please try again.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div>
      <form
        onSubmit={handleSubmit}
        className={`waitlist-form ${isBottomCta ? "bottom-cta" : ""}`}
      >
        <input
          type="email"
          placeholder={"your@email.com"}
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          disabled={loading}
          className="form-input"
        />
        <button
          type="submit"
          disabled={loading}
          className={`form-button ${isBottomCta ? "dark" : ""}`}
        >
          {loading
            ? "Joining..."
            : isBottomCta
            ? "Secure Access"
            : "Get Early Access"}
        </button>
      </form>
      {message && (
        <p
          className={`form-message ${
            message.includes("Successfully") ? "success" : "error"
          }`}
        >
          {message}
        </p>
      )}
    </div>
  );
}

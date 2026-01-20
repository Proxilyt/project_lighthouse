import { serve } from "https://deno.land/std/http/server.ts";
import { Resend } from "npm:resend";

const resend = new Resend(Deno.env.get("RESEND_API_KEY")!)

serve(async (req: Request) => {
  try {
    const { email } = await req.json();

    if (!email || typeof email !== "string" || !email.includes("@")) {
      return new Response(
        JSON.stringify({ error: "Valid email is required" }),
        { status: 400, headers: { "Content-Type": "application/json" } }
      );
    }

    const { data, error } = await resend.emails.send({
      from: "Keshav <keshav@proxilyt.com>",
      to: email,
      replyTo: "main.proxilyt@gmail.com",
      subject: "You're on the Waitlist! Here's What Happens Next",
      html: `
        <h2>Hello and Welcome!</h2>
        <p>Thank you for signing up for the waitlist. We're glad to have you with us.</p>
        <p>You've been added to the early access list for our upcoming SaaS platform. Our goal is to build a product that delivers clear, measurable value from day one, and the waitlist helps us onboard users in a focused and high-quality manner.</p>
        <p>Here's what you can expect next:</p>
        <ul>
          <li>Early updates on product progress and feature releases</li>
          <li>Priority access when we begin onboarding users</li>
          <li>Occasional insights on how teams like yours are solving this problem today</li>
        </ul>
        <p>We are currently onboarding users in small batches to ensure stability, performance, and meaningful feedback. You'll receive an email from us as soon as your access window opens.</p>
        <p>If you have specific use cases or expectations from the product, feel free to reply to this email. Your input directly influences what we build next.</p>
        <p>Thank you for your interest and patience. We look forward to having you onboard soon.</p>
        <p>Best regards,<br/>Keshav Gupta<br />Founder</p>
        <p>P.S. If you'd prefer not to receive any product updates, marketing, or development emails, simply reply with <b>"No"</b>, and we'll stop all future communication.</p>
      `,
    });

    if (error) {
      return new Response(
        JSON.stringify({ error: "Failed to send email" }),
        { status: 500, headers: { "Content-Type": "application/json" } }
      );
    }

    return new Response(JSON.stringify({ success: true, data }), {
      status: 200,
      headers: { "Content-Type": "application/json" },
    });
  } catch (err) {
    console.error("Unexpected error:", err);
    return new Response(
      JSON.stringify({ error: "Internal server error" }),
      { status: 500, headers: { "Content-Type": "application/json" } }
    );
  }
});

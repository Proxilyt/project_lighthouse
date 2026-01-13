import { useState } from 'react'
import { supabase } from '../supabase'

export default function WaitlistForm({ isBottomCta = false }) {
  const [email, setEmail] = useState('')
  const [loading, setLoading] = useState(false)
  const [message, setMessage] = useState('')

  const handleSubmit = async (e) => {
    e.preventDefault()
    
    if (!email) {
      setMessage('Please enter your email')
      return
    }

    setLoading(true)
    setMessage('')

    try {
      const { error } = await supabase
        .from('waitlist')
        .insert([{ email }])

      if (error) {
        if (error.code === '23505') {
          setMessage('This email is already on the waitlist!')
        } else {
          setMessage('Error joining waitlist. Please try again.')
        }
      } else {
        setMessage('Successfully added to waitlist! 🎉')
        setEmail('')
      }
    } catch {
      setMessage('Something went wrong. Please try again.')
    } finally {
      setLoading(false)
    }
  }

  return (
    <form onSubmit={handleSubmit} className={`waitlist-form ${isBottomCta ? 'bottom-cta' : ''}`}>
      <input
        type="email"
        placeholder={isBottomCta ? 'your@email.com' : 'yourname@email.com'}
        value={email}
        onChange={(e) => setEmail(e.target.value)}
        disabled={loading}
        className="form-input"
      />
      <button 
        type="submit" 
        disabled={loading}
        className={`form-button ${isBottomCta ? 'dark' : ''}`}
      >
        {loading ? 'Joining...' : isBottomCta ? 'Secure Access' : 'Get Early Access'}
      </button>
      {message && <p className={`form-message ${message.includes('Successfully') ? 'success' : 'error'}`}>{message}</p>}
    </form>
  )
}

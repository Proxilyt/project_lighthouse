import Header from '../components/Header'
import WaitlistForm from '../components/WaitlistForm'
import { APP_NAME } from '../constants'
import '../pages/Landing.css'

export default function Landing() {
  return (
    <div className="landing">
      {/* Hero Section */}
      <section className="hero">
        <div className="hero-content">
          <div className="beta-badge">DEEPER INSIGHTS — SCAN SITES INSTANTLY</div>
          <h1 className="hero-title">
            Local SEO Analytics
            <br />
            with the <span className="highlight">Speed of Light.</span>
          </h1>
          <p className="hero-description">
            Proximity meets insight. Transform your local search data into
            actionable growth strategies before your competitors even see the
            opportunity.
          </p>
          <WaitlistForm />
        </div>
      </section>

      {/* Featured Image Section */}
      <section className="featured-section">
        <div className="featured-box"></div>
      </section>

      {/* Features Section */}
      <section className="features">
        <div className="features-grid">
          <div className="feature-card">
            <div className="feature-icon">📍</div>
            <h3>Real-time Indexing</h3>
            <p>
              See where your listing live the moment it indexed across major
              local search services. Always stay ahead of the curve.
            </p>
          </div>

          <div className="feature-card">
            <div className="feature-icon">⚡</div>
            <h3>Light-speed Reporting</h3>
            <p>
              Generate reports that matter instantly. Stop wasting time waiting.
              Most real-time insights in local SEO, displayed in just a second.
            </p>
          </div>

          <div className="feature-card">
            <div className="feature-icon">🗺️</div>
            <h3>Geographic Insights</h3>
            <p>
              Track your local positions across multiple areas. Understand your
              footprint across regions and stay on top of your territory.
            </p>
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="cta-section">
        <div className="cta-content">
          <h2>Be the first to know when we launch.</h2>
          <p>
            Join our exclusive waitlist for early access to beta testing, exclusive
            resources and bonus features when we launch.
          </p>
          <div className="cta-form">
            <WaitlistForm isBottomCta={true} />
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="footer">
        <div className="footer-content">
          <span>© {APP_NAME}. All rights reserved.</span>
          <div className="footer-links">
            <a href="#terms">Terms</a>
            <a href="#privacy">Privacy</a>
            <a href="#support">Support</a>
            <a href="#contact">Contact</a>
          </div>
        </div>
      </footer>
    </div>
  )
}

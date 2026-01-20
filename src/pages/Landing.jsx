import WaitlistForm from "../components/WaitlistForm";
import { APP_NAME } from "../constants";
import "../pages/Landing.css";
import featureImage1 from "../assets/feature_image_1.png";
import featureImage2 from "../assets/feature_image_2.png";

export default function Landing() {
  return (
    <div className="landing">
      {/* Hero Section */}
      <section className="hero">
        <div className="hero-content">
          {/* <div className="beta-badge">
            STATUS: WAITING - SOON TO BE DEPLOYED
          </div> */}
          <h1 className="hero-title">
            Local Competitive Analytics
            <br />
            made <span className="highlight">Actionable.</span>
          </h1>
          <p className="hero-description">
            Transform your nearby search data into Actionable Growth Strategies
            before your competitors even see the opportunity.
          </p>
          <WaitlistForm />
        </div>
      </section>

      {/* Features Section */}
      <section id="features" className="features">
        <div className="features-grid">
          <div className="feature-card">
            <div className="feature-icon">🗺️</div>
            <h3>Local Geographic Insights</h3>
            <p>
              Track all the ranks for all the keywords across multiple
              locations.
            </p>
          </div>

          <div className="feature-card">
            <div className="feature-icon">⚡</div>
            <h3>Competitor Analysis</h3>
            <p>
              Get comprehensive competitive insights for all the queries and see
              the lapses in your local SEO strategies
            </p>
          </div>

          <div className="feature-card">
            <div className="feature-icon">💸</div>
            <h3>Keyword Economics</h3>
            <p>
              Understand the cost of appearing in local searches and the amount
              of attention each search term gets.
            </p>
          </div>
        </div>
      </section>

      {/* Featured Image Section */}
      <section className="featured-section perspective-container">
        <div className="tilt-card tilt-card-left">
          <div className="menu-bar-sim">
            <div className="w-2.5 h-2.5 rounded-full bg-red-400/30"></div>
            <div className="w-2.5 h-2.5 rounded-full bg-amber-400/30"></div>
            <div className="w-2.5 h-2.5 rounded-full bg-green-400/30"></div>
          </div>
          <div className="featured-box">
            <img src={featureImage1} alt="feature_image_1" />
          </div>
        </div>
        <div className="tilt-card tilt-card-right">
          <div className="menu-bar-sim">
            <div className="w-2.5 h-2.5 rounded-full bg-red-400/30"></div>
            <div className="w-2.5 h-2.5 rounded-full bg-amber-400/30"></div>
            <div className="w-2.5 h-2.5 rounded-full bg-green-400/30"></div>
          </div>
          <div className="featured-box right-box">
            <img src={featureImage2} alt="feature_image_2" />
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section id="cta-section" className="cta-section">
        <div className="cta-content">
          <h2>Losing sales because of poor ranks?</h2>
          <p>
            You are losing nearby customers to better-ranked competitors. Join
            our exclusive waitlist before more sales slip away.
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
            {/* <a href="#terms">Terms</a>
            <a href="#privacy">Privacy</a>
            <a href="#support">Support</a>
            <a href="#contact">Contact</a> */}
          </div>
        </div>
      </footer>
    </div>
  );
}

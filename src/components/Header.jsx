import { APP_NAME } from "../constants";

export default function Header() {
  return (
    <header className="header">
      <div className="header-container">
        <div className="header__left">
          <div className="logo">
            <span className="logo-icon"> <img src="/src/assets/logo_light_mode.svg" alt="Proxilyt Logo" /></span>
            <span className="logo-text">Proxilyt</span>
          </div>
        </div>
        <nav className="header__right">
          <a href="#features" className="nav-link">
            Features
          </a>
          <button className="cta-button"><a href="#cta-section">Join Waitlist</a></button>
        </nav>
      </div>
    </header>
  );
}

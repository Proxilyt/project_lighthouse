import { APP_NAME } from "../constants";
import logo from "../assets/logo_light_mode.svg";

export default function Header() {
  return (
    <header className="header">
      <div className="header-container">
        <div className="header__left">
          <div className="logo">
            <span className="logo-icon">
              <img src={logo} alt="Proxilyt Logo" />
            </span>
            <span className="logo-text">{APP_NAME}</span>
          </div>
        </div>
        <nav className="header__right">
          <a href="#features" className="nav-link">
            Features
          </a>
          <button className="cta-button">
            <a href="#cta-section">Join Waitlist</a>
          </button>
        </nav>
      </div>
    </header>
  );
}

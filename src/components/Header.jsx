import { APP_NAME } from '../constants'

export default function Header() {
  return (
    <header className="header">
      <div className="header-container">
        <div className="logo">{APP_NAME}</div>
        <button className="get-started-btn">Get Started</button>
      </div>
    </header>
  )
}

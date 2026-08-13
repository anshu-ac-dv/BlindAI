import './CSS/Header.css';

export default function Header() {
  return (
    <header className="header">
      <a href="#" className="logo">
        BlindAI
      </a>
      
      <nav>
        <ul className="nav-list">
          <li><a href="#home" className="nav-link">Home</a></li>
          <li><a href="#services" className="nav-link">Services</a></li>
          <li><a href="#features" className="nav-link">Features</a></li>
          <li><a href="#about" className="nav-link">About</a></li>
        </ul>
      </nav>

      <button className="cta-button">Get Started</button>
    </header>
  );
}
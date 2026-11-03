import React, { useEffect, useState } from 'react';
import { API_URL } from './config';

function App() {
  const [status, setStatus] = useState("Loading...");

  useEffect(() => {
    fetch(`${API_URL}/api/health`)
      .then((res) => res.json())
      .then((data) => setStatus(data.status))
      .catch(() => setStatus("Error connecting to backend"));
  }, []);

  return (
    <div style={{ padding: '20px', fontFamily: 'sans-serif' }}>
      <h1>DevOps Webinar Challenge</h1>
      <p>Backend Status: <strong>{status}</strong></p>
    </div>
  );
}

export default App;
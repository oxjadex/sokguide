import "./App.css";
import React, { useState } from "react";
import SeasonalFoodList from "./SeasonalFoodList";
import FetchSeasonalFood from "./FetchSeasonFood";

function App() {
  const [foods, setFoods] = useState([]); 
  const [loading, setLoading] = useState(false); 
  const [error, setError] = useState(null); 
  const [selectedMonth, setSelectedMonth] = useState(""); 

  const handleMonthChange = (month) => {
    setSelectedMonth(month);
  };

  return (
    <div className="App">
      <FetchSeasonalFood
        selectedMonth={selectedMonth}
        setFoods={setFoods}
        setLoading={setLoading}
        setError={setError}
      />
      {/* 사용자에게 월 선택 UI 제공 */}
      <div>
        <label htmlFor="month-select">월을 선택하세요:</label>
        <select
          id="month-select"
          value={selectedMonth}
          onChange={(e) => handleMonthChange(e.target.value)}
        >
          <option value="">-- 월 선택 --</option>
          <option value="1월">1월</option>
          <option value="2월">2월</option>
          <option value="3월">3월</option>
          <option value="4월">4월</option>
          <option value="5월">5월</option>
          <option value="6월">6월</option>
          <option value="7월">7월</option>
          <option value="8월">8월</option>
          <option value="9월">9월</option>
          <option value="10월">10월</option>
          <option value="11월">11월</option>
          <option value="12월">12월</option>
        </select>
      </div>
      <SeasonalFoodList foods={foods} loading={loading} error={error} />
    </div>
  );
}

export default App;

import "./App.css";
import React, { useState } from "react";
import SeasonalFoodList from "./SeasonalFoodList";
import FetchSeasonalFood from "./FetchSeasonFood";

function App() {
  const [foods, setFoods] = useState([]); // 데이터를 저장할 상태
  const [loading, setLoading] = useState(false); // 로딩 상태
  const [error, setError] = useState(null); // 에러 상태
  const [selectedMonth, setSelectedMonth] = useState(""); // 사용자가 선택한 월

  const handleMonthChange = (month) => {
    setSelectedMonth(month); // 사용자가 선택한 월 상태 업데이트
  };

  return (
    <div className="App">
      {/* FetchSeasonFood에서 데이터를 가져옵니다. */}
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
      {/* SeasonalFoodList에서 데이터를 표시합니다. */}
      <SeasonalFoodList foods={foods} loading={loading} error={error} />
    </div>
  );
}

export default App;

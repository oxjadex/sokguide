import React from "react";

const SeasonalFoodList = ({ foods, loading, error }) => {
  if (loading) return <p>Loading...</p>;
  if (error) return <p>{error}</p>;
  if (foods.length === 0) return <p>현재 월에 해당하는 데이터가 없습니다.</p>;

  return (
    <div>
      <h2>제철 농산물 리스트</h2>
      <div>
        {foods.map((food, index) => (
          <div key={index}>
            <h3>{food.PRDLST_NM}</h3>
            <p>
              <strong>월별:</strong> {food.M_DISTCTNS}
            </p>
            <p>
              <strong>주요 산지:</strong> {food.MTC_NM}
            </p>
            <p>
              <strong>효능:</strong> {food.EFFECT}
            </p>
          </div>
        ))}
      </div>
    </div>
  );
};

export default SeasonalFoodList;

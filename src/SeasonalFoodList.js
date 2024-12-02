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
          <div
            key={index}
            style={{
              border: "1px solid #ccc",
              margin: "10px",
              padding: "10px",
            }}
          >
            <h3>{food.PRDLST_NM}</h3>
            <img
              src={food.IMG_URL || "/placeholder-image.png"}
              alt={food.PRDLST_NM}
              style={{ width: "200px", height: "150px", objectFit: "cover" }}
              onError={(e) => {
                e.target.onerror = null;
                e.target.src = "/placeholder-image.png";
              }}
            />
            <p>
              <strong>식별 번호:</strong> {food.IDNTFC_NO}
            </p>
            <p>
              <strong>월별:</strong> {food.M_DISTCTNS}
            </p>
            <p>
              <strong>월별 항목:</strong> {food.M_DISTCTNS_ITM}
            </p>
            <p>
              <strong>분류:</strong> {food.PRDLST_CL}
            </p>
            <p>
              <strong>주요 산지:</strong> {food.MTC_NM}
            </p>
            <p>
              <strong>생산 기간:</strong> {food.PRDCTN__ERA}
            </p>
            <p>
              <strong>주요 품종:</strong> {food.MAIN_SPCIES_NM}
            </p>
            <p>
              <strong>효능:</strong> {food.EFFECT}
            </p>
            <p>
              <strong>구매 방법:</strong> {food.PURCHASE_MTH}
            </p>
            <p>
              <strong>요리 방법:</strong> {food.COOK_MTH}
            </p>
            <p>
              <strong>손질 방법:</strong> {food.TRT_MTH}
            </p>
            <p>
              <strong>등록일:</strong> {food.REGIST_DE}
            </p>
            <a href={food.URL} target="_blank" rel="noopener noreferrer">
              자세히 보기
            </a>
          </div>
        ))}
      </div>
    </div>
  );
};

export default SeasonalFoodList;

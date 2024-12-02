import React, { useState, useEffect } from "react";
import axios from "axios";
import { XMLParser } from "fast-xml-parser";

const SeasonalFoodList = () => {
  const [foods, setFoods] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchSeasonalFoods = async () => {
      const API_KEY =
        "40dc7b48ad418f2d49063f0fda9c574054406f5e99b06a59b4f95b0470524c6e";
      const BASE_URL =
        "http://211.237.50.150:7080/openapi/sample/xml/Grid_20171128000000000572_1/1/5";

      try {
        const proxyUrl = "https://cors-anywhere.herokuapp.com/";
        const targetUrl = `${proxyUrl}${BASE_URL}`;
        const response = await axios.get(targetUrl, {
          params: { ServiceKey: decodeURIComponent(API_KEY) },
        });


        // XML 데이터를 JSON으로 변환
        const parser = new XMLParser();
        const jsonData = parser.parse(response.data);

        // 안전하게 데이터 추출
        const foodData = jsonData?.Grid_20171128000000000572_1?.row || [];

        if (foodData.length === 0) {
          throw new Error("No data found");
        }

        setFoods(foodData);
        setLoading(false);
      } catch (err) {
        console.error("API 호출 중 오류 발생:", err);
        setError("데이터를 불러오는 중 문제가 발생했습니다.");
        setLoading(false);
      }
    };

    fetchSeasonalFoods();
  }, []);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>{error}</p>;

  return (
    <div>
      <h2>제철 농산물</h2>
      <div>
        {foods.map((food, index) => (
          <div key={index}>
            <img
              src={food.IMG_URL || "/placeholder-image.png"}
              alt={food.PRDLST_NM}
              onError={(e) => {
                e.target.onerror = null;
                e.target.src = "/placeholder-image.png";
              }}
            />
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

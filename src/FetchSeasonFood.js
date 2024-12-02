import React, { useEffect } from "react";
import axios from "axios";

const FetchSeasonFood = ({ selectedMonth, setFoods, setLoading, setError }) => {
  const fetchSeasonalFoods = async (month) => {
    const apiKey =
      "40dc7b48ad418f2d49063f0fda9c574054406f5e99b06a59b4f95b0470524c6e"; // API 키 입력
    const dataType = "json";
    const apiUrl = "Grid_20171128000000000572_1";
    const startIndex = 1;
    const endIndex = 10;
    const proxyUrl = "https://cors-anywhere.herokuapp.com/";
    const targetUrl = "http://211.237.50.150:7080/openapi";
    const endPoint = `${targetUrl}/${apiKey}/${dataType}/${apiUrl}/${startIndex}/${endIndex}`;

    const params = {
      M_DISTCTNS: month, // 선택한 월
    };

    setLoading(true);
    setError(null);

    try {
      const response = await axios.get(endPoint, { params });
      const foodData = response.data?.Grid_20171128000000000572_1?.row || [];
      setFoods(foodData); // 데이터를 App 상태로 전달
    } catch (error) {
      console.error("API 호출 오류:", error);
      setError("데이터를 불러오는 중 오류가 발생했습니다.");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (selectedMonth) {
      fetchSeasonalFoods(selectedMonth); // 선택한 월로 데이터를 가져옴
    }
  }, [selectedMonth]); // selectedMonth가 변경될 때마다 호출

  return null; // 화면에 렌더링하지 않음
};

export default FetchSeasonFood;

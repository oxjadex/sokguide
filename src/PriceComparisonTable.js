import React, { useEffect, useState } from "react";
import axios from "axios";
import { ChevronUpIcon, ChevronDownIcon } from "lucide-react";

const PriceComparisonTable = ({ selectedMonth }) => {
  const [data, setData] = useState([]); // API 데이터 상태
  const [loading, setLoading] = useState(false); // 로딩 상태
  const [error, setError] = useState(null); // 에러 상태
  const [selectedItem, setSelectedItem] = useState(null); // 선택 품목 상태

  const fetchPriceData = async (month) => {
    const apiUrl =
      "https://www.kamis.or.kr/service/price/xml.do?action=dailyPriceByCategoryList";
    const selectedDate = `${new Date().getFullYear()}-${String(
      month.replace("월", "").trim()
    ).padStart(2, "0")}-01`;

    const params = {
      p_cert_key: "72022e48-2028-4036-b462-e798246b67a1", // 인증 키
      p_cert_id: "5020", // 요청자 ID
      p_returntype: "json", // 반환 형식
      p_product_cls_code: "01", // 소매
      p_item_category_code: "100", // 식량작물
      p_country_code: "2100", // 서울
      p_regday: selectedDate,
      p_convert_kg_yn: "Y",
    };

    setLoading(true);
    setError(null);

    try {
      const response = await axios.get(apiUrl, { params });
      setData(response.data.data.item); // item 배열 저장
      setSelectedItem(response.data.data.item);
      console.log("리스폰스", response.data.data.item[0]);
    } catch (error) {
      console.error("API 호출 오류:", error);
      console.error("API 호출 오류 이유딤:", error.response, error);

     setError("미래 가격은 아직 미지수입니다! 다른 날짜를 골라주세요~ 🚀");

    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (selectedMonth) {
      fetchPriceData(selectedMonth);
    }
  }, [selectedMonth]);

  const calculatePriceChange = (current, previous) => {
    if (!current || !previous) return null;
    const change =
      ((parseFloat(current) - parseFloat(previous)) / parseFloat(previous)) *
      100;
    return change;
  };

  const renderPriceChangeIndicator = (change) => {
    if (change === null) return null;
    return (
      <span
        className={`ml-2 flex items-center ${
          change >= 0 ? "text-green-600" : "text-red-600"
        }`}
      >
        {change >= 0 ? (
          <ChevronUpIcon size={16} />
        ) : (
          <ChevronDownIcon size={16} />
        )}
        {Math.abs(change).toFixed(1)}%
      </span>
    );
  };

  if (loading) {
    return <p>데이터를 불러오는 중입니다...</p>;
  }

  if (error) {
    return <p>{error}</p>;
  }

  if (!data || data.length === 0) {
    return <p>월을 선택하여 데이터를 불러와 주세요.</p>;
  }

  return (
    <div className="bg-white shadow-lg rounded-lg overflow-hidden max-w-4xl mx-auto">
      <div className="p-4 bg-gray-100 border-b">
        <h2 className="text-xl font-bold text-gray-800">
          {selectedItem.item_name} ({selectedItem.kind_name}) Price Comparison
        </h2>
        <p className="text-sm text-gray-600">
          품목코드: {selectedItem.item_code} | 품종코드:{" "}
          {selectedItem.kind_code}
        </p>
        <select
          onChange={(e) =>
            setSelectedItem(
              data.find((item) => item.item_name === e.target.value)
            )
          }
          value={selectedItem?.item_name || ""}
        >
          {data.map((item) => (
            <option key={item.item_code} value={item.item_name}>
              {item.item_name} ({item.kind_name})
            </option>
          ))}
        </select>
      </div>

      <div className="p-4">
        <table className="w-full">
          <thead>
            <tr className="bg-gray-50">
              <th className="p-2 text-left">기준</th>
              <th className="p-2 text-right">가격</th>
              <th className="p-2 text-right">변동률</th>
            </tr>
          </thead>
          <tbody>
            {[
              { label: "현재", day: "day1", dpr: "dpr1" },
              { label: "1일 전", day: "day2", dpr: "dpr2" },
              { label: "1주일 전", day: "day3", dpr: "dpr3" },
              { label: "2주일 전", day: "day4", dpr: "dpr4" },
              { label: "1개월 전", day: "day5", dpr: "dpr5" },
              { label: "1년 전", day: "day6", dpr: "dpr6" },
              { label: "평년", day: "day7", dpr: "dpr7" },
            ].map((period, index) => {
              const currentPrice = selectedItem[period.dpr];
              const previousPrice =
                index > 0
                  ? selectedItem[
                      ["dpr1", "dpr2", "dpr3", "dpr4", "dpr5", "dpr6", "dpr7"][
                        index - 1
                      ]
                    ]
                  : null;

              const priceChange = calculatePriceChange(
                currentPrice,
                previousPrice
              );

              return (
                <tr key={period.label} className="border-b hover:bg-gray-50">
                  <td className="p-2 text-gray-700">
                    {period.label} ({selectedItem[period.day]})
                  </td>
                  <td className="p-2 text-right font-semibold">
                    {currentPrice} {selectedItem.unit}
                  </td>
                  <td className="p-2 text-right">
                    {renderPriceChangeIndicator(priceChange)}
                  </td>
                </tr>
              );
            })}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default PriceComparisonTable;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers;

import dao.MotorDAO; // có nên làm cái này ko ae =)), kiểu khi user hỏi vd ymh R5, trong kho có, gemini quăng link cho luôn
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;
import java.net.URL;
import java.net.HttpURLConnection;
import java.io.OutputStreamWriter;
import java.io.BufferedReader;
import java.io.InputStreamReader;

import jakarta.json.Json;
import jakarta.json.JsonObject;
import jakarta.json.JsonReader;
import jakarta.json.JsonString;
import jakarta.json.JsonArray;
import jakarta.json.JsonValue; // dự trù có lỗi thì mới xài

/**
 *
 * @author truon
 */
@WebServlet(name = "ChatServlet", urlPatterns = {"/ChatServlet"})
public class ChatServlet extends HttpServlet {

    private static final String GEMINI_API_KEY = "AIzaSyAOxHxGAfI-VS-I6brZkQuyZ4uYLzdli74"; // **Replace with your actual API key!**
    private static final String GEMINI_API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=" + GEMINI_API_KEY;
    private static final List<String> MOTORCYCLE_KEYWORDS = Arrays.asList(
            // English Keywords (Keep these as well, for English queries)
            "motorcycle", "motorbike", "motorcycles", "motors", "bike", "bikes", "two-wheeler", "two wheelers", "ride", "riding", "biker", "bikers",
            "honda", "yamaha", "harley-davidson", "kawasaki", "suzuki", "ducati", "bmw motorrad", "ktm", "aprilia", "triumph", "indian motorcycle", "royal enfield", "mv agusta", "benelli", "cfmoto", "zero motorcycles", "victory motorcycles", "husqvarna", "gasgas", "moto guzzi",
            "cbr", "r1", "r3", "softail", "cb500x", "ninja", "hayabusa", "gsxr", "panigale", "gs adventure", "duke", "rs660", "speed triple", "scout", "classic 350", "f4", "trk 502", "cforce", "s1000rr", "gold wing", "africa twin", "tenere 700", "v strom", "z900", "monster", "multistrada", "r nine t", "super duke", "tuono", "tiger 900", "chieftain", "meteor 350", "brutale", "leoncino", "nk400", "dsr", "octane", "701 enduro", "ec 250", "v7",
            "sportbike", "sport bike", "cruiser", "touring bike", "adventure bike", "dual sport", "off-road bike", "dirt bike", "enduro bike", "motocross bike", "naked bike", "standard bike", "cafe racer", "scrambler", "bobber", "chopper", "electric motorcycle", "scooter", "moped", "trike", "sidecar",
            "engine", "cylinder", "cylinders", "motor", "wheels", "tire", "tires", "brakes", "suspension", "forks", "shock absorbers", "frame", "chassis", "handlebar", "seat", "fuel tank", "exhaust", "transmission", "clutch", "gearbox", "chain", "belt", "drivetrain", "fairing", "windshield", "lights", "headlight", "taillight", "indicators", "mirrors", "battery", "spark plug", "carburetor", "fuel injection", "ecu", "computer",
            "racing", "touring", "commuting", "off-roading", "stunt riding", "track days", "motorcycle trip", "motorcycle adventure", "motorcycle travel", "motorcycle camping", "motorcycle maintenance", "motorcycle repair", "motorcycle upgrade", "custom motorcycle", "motorcycle mods", "motorcycle accessories", "motorcycle gear", "helmet", "jacket", "gloves", "boots", "leathers",
            "abs", "tcs", "efi", "dct", "vtec", "ohc", "dohc", "cc", "hp", "bhp", "nm", "rpm", "akrapovic", "brembo", "ohlins",
            // Vietnamese Keywords - Từ khóa tiếng Việt
            // General Motorcycle Terms - Thuật ngữ chung về xe máy
            "xe máy", "mô tô", "xe phân khối lớn", "pkl", "xe hai bánh", "xe gắn máy", "xe ôm", "xe", "đi xe", "chạy xe", "dân biker", "người đi xe máy",
            // Brands (Vietnamese and Common English Names) - Thương hiệu (Tên tiếng Việt và tiếng Anh phổ biến)
            "honda", "yamaha", "harley-davidson", "kawasaki", "suzuki", "ducati", "bmw motorrad", "ktm", "aprilia", "triumph", "indian motorcycle", "royal enfield", "mv agusta", "benelli", "cfmoto", "zero motorcycles", "victory motorcycles", "husqvarna", "gasgas", "moto guzzi",
            "honda", "ya-ma-ha", "ha-ley", "ka-wa-sa-ki", "xu-du-ki", "du-ca-ti", "bờ-mờ-vê", "kờ-tờ-mờ", "a-pri-lia", "tờ-rai-umph", "in-đi-an", "rô-y-an en-phiu", "em-vi a-gút-ta", "bê-nê-li", "xê-phờ-mô-tô", "di-rô mô-tô-xai-cờ", "vích-to-ri mô-tô-xai-cờ", "hớt-qua-vác-na", "gát-gát", "mô-tô gu-zi", // Phonetic Vietnamese for English brand names (optional, but can help with mixed input)
            "honda", "yamaha", "ha ley đa vít sơn", "ka wasaki", "suzuki", "ducati", "bmw", "ktm", "aprilia", "triumph", "indian", "royal enfield", "mv agusta", "benelli", "cfmoto", "zero", "victory", "husqvarna", "gas gas", "moto guzzi", // Slightly simplified Vietnamese names (optional)

            // Models (Vietnamese and Common English Names - Examples) - Dòng xe (Tên tiếng Việt và tiếng Anh phổ biến - Ví dụ)
            "cbr", "r1", "r3", "softail", "cb500x", "ninja", "hayabusa", "gsxr", "panigale", "gs adventure", "duke", "rs660", "speed triple", "scout", "classic 350", "f4", "trk 502", "cforce", "s1000rr", "gold wing", "africa twin", "tenere 700", "v strom", "z900", "monster", "multistrada", "r nine t", "super duke", "tuono", "tiger 900", "chieftain", "meteor 350", "brutale", "leoncino", "nk400", "dsr", "octane", "701 enduro", "ec 250", "v7",
            "cbr", "r một", "r ba", "softail", "cb năm trăm x", "ninja", "hayabusa", "g sx r", "panigale", "g s adventure", "duke", "r s sáu trăm sáu mươi", "speed triple", "scout", "classic ba trăm năm mươi", "f bốn", "t r k năm trăm lẻ hai", "c force", "s một ngàn r r", "gold wing", "africa twin", "tenere bảy trăm", "v strom", "z chín trăm", "monster", "multistrada", "r nine t", "super duke", "tuono", "tiger chín trăm", "chieftain", "meteor ba trăm năm mươi", "brutale", "leoncino", "n k bốn trăm", "d s r", "octane", "bảy trăm lẻ một enduro", "e c hai trăm năm mươi", "v bảy", // Vietnamese pronunciation/translation of model names (optional, for mixed input)

            // Types of Motorcycles (Vietnamese) - Loại xe máy (Tiếng Việt)
            "xe thể thao", "xe sportbike", "xe cruiser", "xe đường trường", "xe phượt", "xe adventure", "xe địa hình", "xe cào cào", "xe enduro", "xe motocross", "xe naked", "xe trần trụi", "xe tiêu chuẩn", "xe cafe racer", "xe scrambler", "xe bobber", "xe chopper", "xe máy điện", "xe điện", "xe tay ga", "xe ga", "xe mô tô hai bánh", "xe ba bánh", "xe có thùng", "xe sidecar",
            // Motorcycle Parts & Components (Vietnamese) - Bộ phận và linh kiện xe máy (Tiếng Việt)
            "động cơ", "máy", "xi lanh", "bình xăng", "bánh xe", "lốp xe", "vỏ xe", "phanh", "thắng", "hệ thống treo", "phuộc nhún", "giảm xóc", "khung xe", "sườn xe", "tay lái", "yên xe", "bình xăng lớn", "ống xả", "pô xe", "hộp số", "ly hợp", "côn", "hộp số", "xích", "sên", "dây curoa", "hệ truyền động", "dàn áo", "quây gió", "kính chắn gió", "đèn", "đèn pha", "đèn hậu", "xi nhan", "gương chiếu hậu", "ắc quy", "bình điện", "bugi", "bộ chế hòa khí", "bơm xăng điện tử", "ecu", "máy tính",
            // Motorcycle Activities & Use Cases (Vietnamese) - Hoạt động và mục đích sử dụng xe máy (Tiếng Việt)
            "đua xe", "đi tour", "đi phượt", "đi đường dài", "đi làm", "đi lại hàng ngày", "đi offroad", "biểu diễn", "đua xe đường đất", "đi track", "chuyến đi xe máy", "phượt xe máy", "du lịch xe máy", "cắm trại bằng xe máy", "bảo dưỡng xe máy", "sửa chữa xe máy", "nâng cấp xe máy", "độ xe", "xe độ", "phụ tùng xe máy", "đồ chơi xe máy", "đồ bảo hộ xe máy", "mũ bảo hiểm", "áo giáp", "găng tay", "ủng", "giày", "đồ da",
            // Acronyms & Abbreviations (Vietnamese and English) - Từ viết tắt (Tiếng Việt và tiếng Anh)
            "abs", "tcs", "efi", "dct", "vtec", "ohc", "dohc", "cc", "hp", "bhp", "nm", "rpm", "akrapovic", "brembo", "ohlins",
            "abs", "tcs", "efi", "dct", "vtec", "ohc", "dohc", "cc", "mã lực", "mã lực", "nm", "vòng/phút", "akrapovic", "brembo", "ohlins", // Vietnamese explanation of acronyms if common

            // --- NEW SITUATIONS AND KEYWORDS BELOW ---

            // 1. Daily Commute & Urban Riding in Vietnam (Expanded) - Đi lại hàng ngày & Đi phố ở Việt Nam (Mở rộng)
            "tắc đường", "kẹt xe", "đi làm", "giờ cao điểm", "đường phố đông đúc", "luồn lách", "di chuyển trong phố", "giao thông", "đi lại hàng ngày", "đường xá Việt Nam", "đô thị", "thành phố", "nội thành", "ngoại thành",
            "đỗ xe", "gửi xe", "bãi đỗ xe", "chỗ đậu xe", "vỉa hè", "lề đường", "hầm xe", "gửi xe máy", "điểm giữ xe", "giữ xe", "bảo vệ giữ xe",
            "tiết kiệm xăng", "hao xăng", "tốn xăng", "mức tiêu hao nhiên liệu", "xăng", "giá xăng", "đổ xăng", "nhiên liệu", "xe ít hao xăng", "xe tiết kiệm nhiên liệu", "đổ xăng ở đâu rẻ", "bơm xăng", "trạm xăng",
            "xe nhỏ gọn", "xe tay ga", "xe số", "xe phổ thông", "xe dễ lái", "xe linh hoạt", "xe dễ điều khiển", "luồn lách tốt", "dễ dàng di chuyển", "xe máy cho nữ", "xe máy cho nam", "xe phù hợp đi phố", "xe đi trong thành phố", "xe đi học", "xe đi chợ",
            // 2. Motorcycle Culture & Community in Vietnam (Expanded) - Văn hóa xe máy & Cộng đồng (Mở rộng)
            "câu lạc bộ xe máy", "hội xe", "nhóm biker", "sinh hoạt câu lạc bộ", "giao lưu biker", "offline biker", "đội nhóm xe", "diễn đàn xe máy", "cộng đồng xe máy", "sinh nhật hội", "áo hội", "logo hội", "điều lệ hội", "gia nhập câu lạc bộ", "tham gia hội nhóm",
            "sự kiện xe máy", "triển lãm xe", "festival xe", "ngày hội xe", "gặp mặt biker", "offline hội nhóm", "kỷ niệm thành lập câu lạc bộ", "motor show", "vietnam motorcycle week", "lễ hội xe", "diễu hành xe",
            "đam mê xe máy", "yêu xe", "thích xe", "nghiện xe", "hội yêu xe", "dân chơi xe", "tinh thần biker", "lòng yêu xe", "độ xe kiểng", "xe đẹp", "xe chất", "xe độc", "xe lạ", "xe phong cách", "xe cá tính",
            // 3. Motorcycle Maintenance & Repair in Vietnam (Expanded) - Bảo dưỡng & Sửa chữa xe máy (Mở rộng)
            "sửa xe giá rẻ", "tiệm sửa xe bình dân", "phụ tùng thay thế", "đồ thay xe", "linh kiện xe máy", "vật tư xe máy", "dịch vụ sửa xe", "gara xe máy", "thợ sửa xe", "sửa xe vỉa hè", "tiệm sửa xe ven đường", "sửa xe lưu động", "cứu hộ xe máy", "vá xe", "bơm vá xe", "thay lốp xe", "thay săm xe",
            "tự sửa xe", "tự bảo dưỡng", "tự làm", "hướng dẫn sửa xe", "video hướng dẫn", "cách sửa xe", "mẹo sửa xe", "dụng cụ sửa xe", "đồ nghề sửa xe", "sách hướng dẫn sửa xe", "tự thay nhớt", "tự thay lốp", "tự vá xe", "tự chỉnh xăng gió", "tự bảo trì",
            "bảo dưỡng định kỳ", "bảo trì xe", "chăm sóc xe", "kiểm tra xe định kỳ", "lịch bảo dưỡng", "thay nhớt", "thay dầu", "bảo dưỡng phuộc", "bảo dưỡng thắng", "bảo dưỡng động cơ", "vệ sinh xe", "rửa xe", "đánh bóng xe", "dưỡng sên", "bơm lốp", "kiểm tra áp suất lốp",
            "lỗi xe thường gặp", "xe bị hư", "xe không nổ máy", "xe chết máy", "xe bị ngập nước", "xe vô nước", "xe bị hỏng", "xe bị đề không được", "xe yếu máy", "xe ì", "xe kêu", "xe rung", "xe bị giật", "xe ăn xăng", "xe hao bình", "xe hở bạc", "xe lúp bê",
            // 4. Motorcycle Purchase & Ownership in Vietnam (Expanded) - Mua bán & Sở hữu xe máy (Mở rộng)
            "xe máy phổ biến nhất VN", "xe máy bán chạy nhất", "top xe máy VN", "xe máy ưa chuộng", "xe máy thị trường VN", "xe máy Việt Nam", "xe nhập khẩu", "xe lắp ráp trong nước", "xe liên doanh", "xe nhập khẩu nguyên chiếc", "xe lắp ráp trong nước", "xe chính hãng", "xe nhập khẩu tư nhân", "xe ga quốc dân",
            "xe máy cũ", "mua xe cũ", "bán xe cũ", "chợ xe máy cũ", "cửa hàng xe cũ", "xe đã qua sử dụng", "xe lướt", "xe second hand", "giá xe cũ", "định giá xe cũ", "kiểm tra xe cũ", "mua bán xe cũ", "xe cũ giá rẻ", "xe cũ chất lượng", "xe cũ biển số đẹp", "xe cũ chính chủ", "xe cũ sang tên",
            "trả góp xe máy", "mua xe trả góp", "vay mua xe", "lãi suất trả góp", "thủ tục trả góp", "ngân hàng cho vay mua xe", "công ty tài chính xe máy", "mua xe trả chậm", "trả góp 0%", "trả góp lãi suất thấp", "mua xe trả góp online", "mua xe máy trả góp không cần trả trước",
            "đăng ký xe máy", "làm giấy tờ xe", "cà vẹt xe", "biển số xe", "sang tên xe", "chuyển nhượng xe", "giấy phép lái xe A1", "giấy phép lái xe A2", "luật giao thông", "vi phạm giao thông", "nộp phạt nguội", "đăng kiểm xe máy", "lệ phí trước bạ", "thuế trước bạ", "bảo hiểm xe máy", "bảo hiểm bắt buộc", "bảo hiểm tự nguyện", "mất cà vẹt xe", "mất biển số xe",
            // 5. Motorcycle Touring & Travel in Vietnam (Expanded) - Du lịch & Phượt xe máy (Mở rộng)
            "tuyến đường phượt", "đường đẹp Việt Nam", "cung đường phượt", "điểm đến phượt", "phượt Tây Bắc", "phượt Đông Bắc", "phượt Tây Nguyên", "phượt ven biển", "phượt đèo", "đèo Mã Pí Lèng", "đèo Hải Vân", "cung đường chữ S", "phượt Hà Giang", "phượt Sapa", "phượt Mộc Châu", "phượt Đà Lạt", "phượt Nha Trang", "phượt Vũng Tàu", "phượt miền Tây", "kinh nghiệm phượt", "lịch trình phượt", "review phượt", "chia sẻ kinh nghiệm phượt",
            "thuê xe máy", "cho thuê xe máy", "dịch vụ thuê xe", "thuê xe phượt", "giá thuê xe", "địa điểm thuê xe", "thuê xe tự lái", "xe cho thuê du lịch", "thuê xe máy Hà Nội", "thuê xe máy Sài Gòn", "thuê xe máy Đà Nẵng", "thuê xe máy Phú Quốc", "thủ tục thuê xe", "hợp đồng thuê xe",
            "đồ phượt xe máy", "trang bị phượt", "áo mưa", "bạt trùm xe", "dây ràng đồ", "đồ nghề sửa xe phượt", "bản đồ phượt", "gps xe máy", "đèn pin", "lều trại", "túi ngủ", "balo phượt", "đồ bảo hộ đi tour", "găng tay phượt", "giày phượt", "mũ fullface", "mũ 3/4", "áo khoác phượt", "quần phượt", "giáp bảo hộ", "camera hành trình xe máy",
            // 6. Vietnamese Specific Motorcycle Types - Loại xe máy đặc trưng Việt Nam
            "xe wave", "wave alpha", "wave rsx", "wave blade", "xe dream", "dream thái", "dream lùn", "xe cub", "cub 81", "cub 82", "xe 67", "simson", "minsk", "xe ba gác", "xe lôi", "xe chở hàng", "xe cup", "xe cúp", "xe số phổ thông", "xe số honda", "xe số yamaha",
            // 7. Brands/Models Popular in Vietnam - Thương hiệu/Dòng xe phổ biến ở Việt Nam (More Specific)
            "honda vision", "honda air blade", "honda lead", "honda sh mode", "honda sh", "honda winner x", "honda vario", "yamaha sirius", "yamaha exciter", "yamaha jupiter", "yamaha grande", "yamaha janus", "vespa sprint", "vespa primavera", "piaggio liberty", "piaggio medley", "sym attila", "sym elizabeth", "vinfast feliz", "vinfast klara", "vinfast evo", "xe điện vinfast", "xe máy điện vinfast",
            // 8. Legal & Regulations in Vietnam - Luật & Quy định ở Việt Nam
            "luật giao thông đường bộ", "biển báo giao thông", "vạch kẻ đường", "tốc độ giới hạn", "nồng độ cồn", "mũ bảo hiểm", "quy định về mũ bảo hiểm", "chở quá số người quy định", "vượt đèn đỏ", "đi ngược chiều", "đi sai làn đường", "phạt nguội", "mức phạt giao thông", "điều khiển xe khi say rượu", "đua xe trái phép", "xe không giấy tờ", "xe lậu", "xe gian",
            // 9. Safety and Security Concerns in Vietnam - An toàn và An ninh ở Việt Nam
            "mất xe", "trộm xe", "cướp xe", "chống trộm xe", "khóa chống trộm", "còi báo động chống trộm", "gps định vị xe", "bảo hiểm chống mất cắp xe", "khu vực hay mất xe", "điểm đen giao thông", "tai nạn giao thông xe máy", "va chạm xe", "kỹ năng lái xe an toàn", "lái xe phòng thủ", "tránh tai nạn", "đường trơn trượt", "mùa mưa đi xe máy", "đi đêm bằng xe máy"
    );

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            String message = request.getParameter("message");
            if (message == null || message.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.write("Please provide a message");
                return;
            }
            
            HttpSession session = request.getSession();
            Integer questionCount = (Integer) session.getAttribute("questionCount");
            if (questionCount == null) {
                questionCount = 0;
            }

            String aiResponseText;
            if (isMotorcycleRelated(message)) {
                aiResponseText = getGeminiApiResponse(message); // Call Gemini API
                if (aiResponseText == null || aiResponseText.isEmpty()) {
                    aiResponseText = "I apologize, but I couldn't get a proper response. Please try again or ask a different question about motorcycles.";
                }
            } else {
                aiResponseText = "I'm an AI assistant specialized in motorcycles. Please ask me about motorcycles, bikes, riding, or related topics.";
            }

            questionCount++;
            session.setAttribute("questionCount", questionCount);

            out.write(aiResponseText);
        } catch (Exception e) {
            // Log the error (in production, use a proper logger)
            e.printStackTrace();
            
            // Send a friendly error message to the client
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("Sorry, I'm having trouble processing your request right now. Please try again later.");
        } finally {
            out.close();
        }
    }

    private boolean isMotorcycleRelated(String message) {
        String lowerCaseMessage = message.toLowerCase();
        for (String keyword : MOTORCYCLE_KEYWORDS) {
            if (lowerCaseMessage.contains(keyword)) {
                return true;
            }
        }
        return false;
    }

    private String getGeminiApiResponse(String message) {
        try {
            URL url = new URL(GEMINI_API_URL);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setDoOutput(true);
            connection.setConnectTimeout(10000);  // 10 second timeout for connection
            connection.setReadTimeout(30000);     // 30 second timeout for reading

            // Sanitize the message for JSON
            String sanitizedMessage = message.replace("\\", "\\\\")
                                           .replace("\"", "\\\"")
                                           .replace("\n", "\\n")
                                           .replace("\r", "\\r");
            
            String jsonInputString = String.format(
                "{\"contents\": [{\"parts\":[{\"text\": \"Answer this motorcycle-related question in a helpful, friendly and concise way: %s\"}]}]}", 
                sanitizedMessage);

            try (OutputStreamWriter writer = new OutputStreamWriter(connection.getOutputStream(), "UTF-8")) {
                writer.write(jsonInputString);
                writer.flush();
            }

            int responseCode = connection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                try (BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"))) {
                    // Use Jakarta JSON Processing to parse the JSON response
                    JsonReader jsonReader = Json.createReader(reader);
                    JsonObject jsonResponse = jsonReader.readObject();
                    jsonReader.close();

                    String aiTextResponse = extractTextFromGeminiResponse(jsonResponse);
                    if (aiTextResponse != null) {
                        return aiTextResponse;
                    } else {
                        return "Sorry, I couldn't extract the text from the AI response. Please try again.";
                    }
                }
            } else {
                // Read error stream for better diagnosis
                try (BufferedReader errorReader = new BufferedReader(new InputStreamReader(
                        connection.getErrorStream() != null ? connection.getErrorStream() : 
                        new java.io.ByteArrayInputStream(new byte[0])))) {
                    StringBuilder errorResponse = new StringBuilder();
                    String line;
                    while ((line = errorReader.readLine()) != null) {
                        errorResponse.append(line);
                    }
                    System.err.println("Gemini API error: " + errorResponse.toString());
                }
                
                return "I'm having trouble connecting to my knowledge source (Error: " + responseCode + "). Please try again later.";
            }
        } catch (IOException e) {
            e.printStackTrace();
            return "I'm having technical difficulties right now. Please try again in a moment.";
        }
    }

    private String extractTextFromGeminiResponse(JsonObject jsonResponse) {
        try {
            if (jsonResponse.containsKey("candidates")) {
                JsonArray candidates = jsonResponse.getJsonArray("candidates");
                if (!candidates.isEmpty()) {
                    JsonObject candidate = candidates.getJsonObject(0);
                    if (candidate.containsKey("content")) {
                        JsonObject content = candidate.getJsonObject("content");
                        if (content.containsKey("parts")) {
                            JsonArray parts = content.getJsonArray("parts");
                            if (!parts.isEmpty()) {
                                JsonObject part = parts.getJsonObject(0);
                                if (part.containsKey("text")) {
                                    JsonString textValue = part.getJsonString("text");
                                    return textValue.getString();
                                }
                            }
                        }
                    }
                }
            }
            
            // If we can't find the expected structure, log the actual response for debugging
            System.err.println("Unexpected Gemini response structure: " + jsonResponse.toString());
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method not supported for ChatServlet");
    }
}

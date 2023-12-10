package com.team1.careercanvas.Controller;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.team1.careercanvas.mapper.BoardMapper;
import com.team1.careercanvas.mapper.PofolMapper;
import com.team1.careercanvas.mapper.UserMapper;
import com.team1.careercanvas.vo.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

import static com.team1.careercanvas.util.OCRTemplate.OCR;
import static com.team1.careercanvas.util.securePassword.encryptWithSalt;

@Controller
public class UserController {

    private final UserMapper mapper;
    private final PofolMapper pofolmapper;
    private final BoardMapper boardmapper;

    public UserController(UserMapper mapper, PofolMapper pofolmapper, BoardMapper boardmapper) {
        this.mapper = mapper;
        this.pofolmapper = pofolmapper;
        this.boardmapper = boardmapper;
    }

    @GetMapping("/findpw")
    public String findpw(HttpSession session) {
        if (session.getAttribute("LogStatus") == "Y") {
            session.setAttribute("msg", "잘못된 접근입니다.");

            return "alert_page";
        }
        return "users/findpw";
    }

    @GetMapping("/login")
    public String login(HttpSession session) {
        if (session.getAttribute("LogStatus") == "Y") {
            session.setAttribute("msg", "잘못된 접근입니다.");
            return "alert_page";
        }
        return "users/login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/signup")
    public String signup(HttpSession session) {
        if (session.getAttribute("LogStatus") == "Y") {
            session.setAttribute("msg", "잘못된 접근입니다.");
            return "alert_page";
        }
        return "users/signup-start";
    }

    @GetMapping("/signup/personal")
    public String signup_personal(HttpSession session) {
        if (session.getAttribute("LogStatus") == "Y") {
            session.setAttribute("msg", "잘못된 접근입니다.");
            return "alert_page";
        }
        return "users/signup-personal";
    }

    @GetMapping("/signup/biz")
    public String signup_biz(HttpSession session) {
        if (session.getAttribute("LogStatus") == "Y") {
            session.setAttribute("msg", "잘못된 접근입니다.");
            return "alert_page";
        }
        return "/users/signup-biz-upload";
    }

    @GetMapping("/findid")
    public String findid(HttpSession session) {
        if (session.getAttribute("LogStatus") == "Y") {
            session.setAttribute("msg", "잘못된 접근입니다.");
            return "alert_page";
        }
        return "users/findid";
    }

    @PostMapping("checkId")
    @ResponseBody
    public int checkid(@RequestParam("id") String input) {
        return mapper.idCheck(input);
    }

    @PostMapping("checkName")
    @ResponseBody
    public int checkname(@RequestParam("name") String input) {
        return mapper.namecheck(input);
    }

    @PostMapping("checkemail")
    @ResponseBody
    public int checkemail(@RequestParam("email") String input) {
        return mapper.emailcheck(input);
    }

    @GetMapping("/changepwd")
    public String pwdchange(@RequestParam("id") String originpwd,
            HttpSession session,
            HttpServletRequest request) {
        if (session != null || !session.isNew()) {
            session.invalidate();
            session = request.getSession(true);
        }

        List<Integer> list = new ArrayList<Integer>();

        String userid = mapper.getUserIdByPwd(originpwd);
        UserVO saltcheck = mapper.getUser(userid);
        if (!saltcheck.getUsersalt().equals("dontbreakmysalt")) {
            session.setAttribute("msg", "잘못된 접근입니다!");
            return "alert_page";
        }
        if (userid == null) {
            session.setAttribute("msg", "잘못된 접근입니다!");
            return "alert_page";
        } else {
            session.setAttribute("userid", userid);
            return "users/changepwd_byemail";
        }
    }

    @PostMapping("startchangepwd")
    public String startchangepwd(@RequestParam("userPwd") String newpassword,
            HttpSession session) throws NoSuchAlgorithmException {
        String userid = (String) session.getAttribute("userid");
        String[] secureValue = encryptWithSalt(newpassword);
        String encryptedpwd = secureValue[0];
        String salt = secureValue[1];
        mapper.changePwd(userid, encryptedpwd, salt);
        return "redirect:/login";
    }

    @PostMapping("/signup/personalstart")
    public String signUpPersonal(@RequestParam("userId") String userid,
            @RequestParam("userPwd") String userpwd,
            @RequestParam("userNickName") String username,
            @RequestParam("userEmail") String useremail,
            @RequestParam("usertel") String usertel,
            HttpSession session) {
        try {
            String[] securearr = encryptWithSalt(userpwd);
            mapper.signupPersonal(userid, securearr[0], username, useremail, usertel, 0, securearr[1]);

            int length = userid.length();
            String firstPart = userid.substring(0, 2);
            String lastPart = userid.substring(length - 2, length);

            StringBuilder asterisks = new StringBuilder();
            for (int i = 0; i < length - 4; i++) {
                asterisks.append("*");
            }

            String result = firstPart.concat(String.valueOf(asterisks)).concat(lastPart);
            session.setAttribute("tempID", result);
            session.setAttribute("tempmail", useremail);
            return "/users/personal_end";
        } catch (Exception e) {
            return "404pages";
        }
    }

    @PostMapping("/signup/biz-middle")
    public String bizupload(@RequestParam("ex_file") MultipartFile file,
            HttpSession session) {

        if (file.isEmpty()) {
            System.out.println("파일없음");
            return "404pages";
        }
        // 파일저장시작

        String letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        Random random = new Random();
        StringBuilder salt = new StringBuilder(8);
        for (int i = 0; i < 8; i++) {
            int index = random.nextInt(letters.length());
            salt.append(letters.charAt(index));
        }
        String saltString = salt.toString();

        String extension = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
        String newFileName = saltString + extension;
        String projectDir = new File("").getAbsolutePath();
        File directory = new File(projectDir + "/upload/authtemp");
        if (!directory.exists()) {
            directory.mkdirs(); // 디렉토리 생성
        }

        Path path = Paths.get(directory.getAbsolutePath(), newFileName); // 절대 경로를 사용

        try {
            file.transferTo(new File(path.toString()));
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("파일저장실패");
            return "404pages";
        }
        // 파일저장 끝

        System.out.println(path);

        String result = OCR(String.valueOf(path));

        System.out.println(result);
        // 결과 json에서 inferResult가 "FAILURE"면 아닌걸로 취급, "SUCCESS"면 성공
        JsonElement jsonElement = JsonParser.parseString(result);
        JsonObject jsonObject = jsonElement.getAsJsonObject();

        String isSuccess = jsonObject.getAsJsonArray("images").get(0).getAsJsonObject().get("inferResult")
                .getAsString();
        System.out.println(isSuccess);
        String companyno = "";
        String username = "";
        if (isSuccess.equals("SUCCESS")) {
            companyno = jsonObject.getAsJsonArray("images").get(0).getAsJsonObject().getAsJsonArray("fields").get(0)
                    .getAsJsonObject().get("inferText").getAsString();
            username = jsonObject.getAsJsonArray("images").get(0).getAsJsonObject().getAsJsonArray("fields").get(1)
                    .getAsJsonObject().get("inferText").getAsString();
            // 가입한 회원이였으면 빠꾸먹이기

            int countCompanyNo = mapper.CheckCompanyNo(companyno);

            if (countCompanyNo >= 1) {
                session.setAttribute("msg", "이미 가입된 회원입니다. 가입하지 않으셨다면 관리자에게 메일로 문의주세요");
                return "alert_page";
            }

        } else if (isSuccess.equals("FAILURE")) {
            session.setAttribute("msg", "인식할 수 없습니다. 오류가 반복되면 메일로 문의바랍니다.");
            return "alert_page";
        } else {
            return "404pages";
        }
        // companyno 중복 검사 해주기
        session.setAttribute("companyno", companyno);
        session.setAttribute("username", username);
        session.setAttribute("tempimg", path);
        // db에 경로넣기 끝
        // 이제 신청이 완료되었음 하고 로그인으로 보내든 해야함
        return "users/signup-biz";
    }

    @PostMapping("/signup/biz/complete")
    public String bizComplete(String userId,
            String userPwd,
            String userNickName,
            String userEmail,
            String usertel,
            String companyno,
            String tempimg,
            HttpSession session) throws NoSuchAlgorithmException {

        UserVO uvo = new UserVO();
        uvo.setUserid(userId);
        uvo.setUsername(userNickName);
        uvo.setUseremail(userEmail);
        uvo.setUsertel(usertel);

        String[] pwdarr = encryptWithSalt(userPwd);

        uvo.setUserpwd(pwdarr[0]);
        uvo.setUsersalt(pwdarr[1]);
        uvo.setUsertype(1);

        mapper.SignupBizFirst(uvo);
        System.out.println(uvo);
        // temp이미지 처리
        Path source = Paths.get(tempimg);

        String targetDir = new File("").getAbsolutePath() + "/upload/companyauth";
        File targetDirectory = new File(targetDir);
        if (!targetDirectory.exists()) {
            targetDirectory.mkdirs();
        }

        String extension = tempimg.substring(tempimg.lastIndexOf("."));
        Path targetPath = Paths.get(targetDirectory.getAbsolutePath(), companyno + extension);
        try {
            Files.copy(source, targetPath, StandardCopyOption.REPLACE_EXISTING);
        } catch (Exception e) {
            e.printStackTrace();
        }
        // temp이미지 처리 끝
        mapper.SignupBizSecond(uvo.getUserid(), companyno, "/companyauth/" + companyno + extension);
        session.setAttribute("msg", "신청이 완료되었습니다. 예정 소요기간은 1~3영업일입니다.");

        return "alert_page";
    }

    @PostMapping("/loginOk")
    public String loginOk(HttpSession session, UserVO vo,
            @RequestParam("usertype") int usertype,
            @RequestParam("userid") String userid,
            @RequestParam("userpwd") String userpwd,
            @RequestParam(value = "companyno", required = false) String companyno) {// vo쓰면 안됨.
        // 아직 관리자로그인 고려안함
        try {
            if (usertype == 0 || usertype == 2) {// 개인로그인, 관리자로그인
                UserVO userInDB = mapper.getUser(userid);
                if (userInDB.getUsertype() == 1) {
                    session.setAttribute("msg", "일치하는 정보가 없습니다.");
                    return "alert_page";
                }
                System.out.println(userInDB.getUsersalt());

                if (!Objects.equals(userInDB.getUsersalt(), "dontbreakmysalt")) {

                    String encryptedInputPwd = encryptWithSalt(userpwd, userInDB.getUsersalt())[0];

                    if (!userInDB.getUserpwd().equals(encryptedInputPwd)) {
                        session.setAttribute("msg", "일치하는 정보가 없습니다.");
                        return "alert_page";
                    } else {
                        session.setAttribute("LogStatus", "Y");
                        session.setAttribute("LogId", userid);
                        session.setAttribute("usertype", userInDB.getUsertype());
                        session.setAttribute("Logusername", userInDB.getUsername());
                        session.setAttribute("LogImg", userInDB.getProfileimg());
                        return "index";
                    }
                } else {
                    session.setAttribute("msg", "비밀번호 변경 후 진행해주세요. 메일함을 확인해주세요.");
                    return "alert_page";
                }

            } else {// 기업로그인
                UserVO userInDB = mapper.getUser(userid);
                if (!Objects.equals(userInDB.getUsersalt(), "dontbreakmysalt")) {
                    String companynoInDB = mapper.getBizNo(userid);
                    int isaccept = mapper.getAccept(userid);

                    String encryptedInputPwd = encryptWithSalt(userpwd, userInDB.getUsersalt())[0];

                    if (!userInDB.getUserpwd().equals(encryptedInputPwd) || !companynoInDB.equals(companyno)) {
                        session.setAttribute("msg", "일치하는 정보가 없습니다.");
                        return "alert_page";
                    } else if (isaccept != 0) {
                        session.setAttribute("msg", "승인 대기중입니다.");
                        return "alert_page";
                    } else {
                        session.setAttribute("LogStatus", "Y");
                        session.setAttribute("LogId", userid);
                        session.setAttribute("usertype", usertype);
                        session.setAttribute("LogImg", userInDB.getProfileimg());
                        return "redirect:/";
                    }
                } else {
                    session.setAttribute("msg", "비밀번호 변경 후 진행해주세요.메일함을 확인해주세요.");
                    return "alert_page";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "404pages";//
        }
    }

    // 권혁준 작업
    // 완료
    @GetMapping("mypage_edit")
    public ModelAndView mypageEdit(HttpSession session, String LogId) {
        ModelAndView mav = new ModelAndView();
        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("logStatus");

        if (logStatus != "Y" && logId == null) {
            mav.setViewName("redirect:/");
            return mav;
        }

        UserVO result = mapper.getUserInfo(logId);
        mav.addObject("uVO", result);
        mav.setViewName("users/mypage_edit");
        return mav;
    }

    @PostMapping("nickNameCheck")
    @ResponseBody
    public int nickNameCheck(HttpSession session, String nickname) {
        int result = mapper.getAllUserNickname(nickname);
        String myNickname = (String) session.getAttribute("Logusername");
        if (result == 1) {
            if (myNickname.equals(nickname)) {
                result = 0;
            }
        }
        return result;
    }

    // 완료
    @PostMapping("mypageEditOk")
    public String mypageEditOk(
            @RequestParam("password") String pwd,
            @RequestParam("nickName") String nickName,
            @RequestParam("tel") String tel,
            @RequestParam("comment") String comment,
            @RequestParam(value = "fileInput", required = false) MultipartFile file,
            @RequestParam(name = "interest", required = false) String interest,
            HttpSession session) throws NoSuchAlgorithmException {

        if (interest != null) {
            String str = String.join(",", interest);
            int saveInterestResult = mapper.saveInterest((String) session.getAttribute("LogId"), str);
        }
        if (!session.getAttribute("LogStatus").equals("Y")) {
            session.setAttribute("msg", "잘못된 접근입니다.");
            return "alert_page";
        }

        String userid = (String) session.getAttribute("LogId");
        mapper.updateMypageWithoutPwd(nickName, tel, comment, userid);
        session.setAttribute("Logusername", nickName);

        if (pwd != null && !Objects.equals(pwd, "")) {
            // 비밀번호도 변경해야함
            // 프론트에서 유효성 검사가 끝났다는 가정하에 시작
            String[] secureValue = encryptWithSalt(pwd);
            String encryptedpwd = secureValue[0];
            String salt = secureValue[1];
            mapper.changePwd(userid, encryptedpwd, salt);
        }

        if (!file.isEmpty()) {
            // 파일저장시작
            String currentTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
            String extension = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
            String newFileName = userid + "_" + currentTime + extension;
            String projectDir = new File("").getAbsolutePath();
            File directory = new File(projectDir + "/upload/userprofileimg");
            if (!directory.exists()) {
                directory.mkdirs(); // 디렉토리 생성
            }

            Path path = Paths.get(directory.getAbsolutePath(), newFileName); // 절대 경로를 사용

            try {
                file.transferTo(new File(path.toString()));
            } catch (IOException e) {
                e.printStackTrace();
                System.out.println("파일저장실패");
                return "404pages";
            }
            // 파일저장 끝

            // 기존파일 삭제
            String oldFileName = mapper.getProfileImg(userid);
            if (oldFileName != null || oldFileName != "") {
                File fileToDelete = new File(directory, oldFileName.substring(oldFileName.lastIndexOf('/') + 1));
                boolean result = fileToDelete.delete();

                if (result) {
                    System.out.println("파일 삭제 성공");
                } else {
                    System.out.println("파일 삭제 실패");
                }
            }

            // db에 경로넣기
            String imgsrc = "/userprofileimg/" + newFileName;

            mapper.InsertProfileImg(imgsrc, userid);
            // db에 경로넣기 끝
            session.setAttribute("LogImg", imgsrc);
        }

        return "redirect:/mypage/myPofol";
    }

    // 권혁준 작업
    // 완료
    @GetMapping("mypage/myPofol")
    public ModelAndView myPofol(HttpSession session, PagingVO pVO) {
        ModelAndView mav = new ModelAndView();

        if (session.getAttribute("LogStatus") == null || !session.getAttribute("LogStatus").equals("Y")) {
            session.setAttribute("msg", "잘못된 접근입니다.");
            mav.setViewName("alert_page");
            return mav;
        }

        if (pVO.getSearchWord() == null) {
            pVO.setSearchWord("");
        }
        pVO.setSearchKey((String) session.getAttribute("LogId"));
        pVO.setOnePageRecord(12);
        pVO.setPage(pVO.getPage());
        pVO.setTotalRecord(pofolmapper.getPofolCount(pVO));

        List<PofolVO> list = new ArrayList<PofolVO>();

        list = pofolmapper.getPofol(pVO);
        UserVO uVO = mapper.getUserInfo((String) session.getAttribute("LogId"));
        if (uVO.getInterest() != null) {
            String[] interestArr = uVO.getInterest().split(",");
            mav.addObject("interest", interestArr);
        }
        mav.addObject("searchWord", pVO.getSearchWord());
        mav.addObject("pVO", pVO);
        mav.addObject("uVO", uVO);
        mav.addObject("list", list);
        mav.setViewName("users/mypage");
        return mav;
    }

    @GetMapping("mypage/myPofol/write")
    public String pofolWrite() {
        return "users/mypage_pofolWrite";
    }

    @PostMapping("mypage/myPofol/writeOk")
    public String pofolWriteOk(HttpSession session,
            @RequestParam("posttitle") String title,
            @RequestParam("postcontent") String content,
            @RequestParam("category") String category) throws IOException {

        PofolVO pvo = new PofolVO();
        pvo.setPortfoliotitle(title);
        pvo.setPortfoliocontent(content);
        pvo.setCategory(category);
        pvo.setUser_userid((String) session.getAttribute("LogId"));

        int result = mapper.pofolWrite(pvo);

        System.out.println(content);
        if (content.contains("<img src=")) {
            int index = content.indexOf("<img src=");
            String first = content.substring(index + 10);
            String second = first.substring(0, first.indexOf("\""));// mime 포함 src내 전체 코드
            String mimeType = second.split(",")[0].split(";")[0].split(":")[1];
            String base64Data = second.split(",")[1];

            String extension = mimeType.split("/")[1];

            byte[] data = Base64.getDecoder().decode(base64Data);

            String userid = String.valueOf(pvo.getPortfolioid());
            String newFileName = userid + "." + extension;

            String projectDir = new File("").getAbsolutePath();
            File directory = new File(projectDir + "/upload/pofolimg");
            if (!directory.exists()) {
                directory.mkdirs();
            }

            Path path = Paths.get(directory.getAbsolutePath(), newFileName);
            OutputStream outputStream = new FileOutputStream(path.toString());
            outputStream.write(data);
            outputStream.close();

            String pathfordb = "/pofolimg/" + newFileName;
            // 여기서 db에 path만 넣어주면 됨.
            int dbresult = pofolmapper.insertImg(pathfordb, pvo.getPortfolioid());

        }

        return "redirect:/mypage/myPofol";
    }

    // 완료
    @GetMapping("mypage/myPost")
    public ModelAndView myPost(HttpSession session,
            PagingVO pVO) {
        ModelAndView mav = new ModelAndView();
        if (!session.getAttribute("LogStatus").equals("Y")) {
            session.setAttribute("msg", "잘못된 접근입니다.");
            mav.setViewName("alert_page");
            return mav;
        }
        if (pVO.getSearchWord() == null) {
            pVO.setSearchWord("");
        }
        pVO.setSearchKey((String) session.getAttribute("LogId"));
        pVO.setOnePageRecord(10);
        pVO.setPage(pVO.getPage());
        pVO.setTotalRecord(boardmapper.getmyPostAmount(pVO));

        List<BoardVO> bVO = new ArrayList<BoardVO>();
        bVO = boardmapper.getmyPost(pVO);

        UserVO uVO = mapper.getUserInfo((String) session.getAttribute("LogId"));
        if (uVO.getInterest() != null) {
            String[] interestArr = uVO.getInterest().split(",");
            System.out.println("arr size : " + interestArr.length);
            mav.addObject("interest", interestArr);
        }
        mav.addObject("pVO", pVO);
        mav.addObject("bVO", bVO);
        mav.addObject("uVO", uVO);
        mav.setViewName("users/mypage_post");
        System.out.println(pVO);
        return mav;
    }

    @GetMapping("mypage/myComment")
    public ModelAndView myComment(HttpSession session, PagingVO pVO) {

        ModelAndView mav = new ModelAndView();
        if (!session.getAttribute("LogStatus").equals("Y")) {
            session.setAttribute("msg", "잘못된 접근입니다.");
            mav.setViewName("alert_page");
            return mav;
        }

        if (pVO.getSearchWord() == null) {
            pVO.setSearchWord("");
        }
        pVO.setSearchKey((String) session.getAttribute("LogId"));
        pVO.setOnePageRecord(5);
        pVO.setTotalRecord(boardmapper.getmyCommentCount(pVO));
        pVO.setPage(pVO.getPage());
        List<CommentVO> cVO = new ArrayList<CommentVO>();

        cVO = boardmapper.getmyComment(pVO);
        UserVO uVO = mapper.getUserInfo((String) session.getAttribute("LogId"));
        if (uVO.getInterest() != null) {
            String[] interestArr = uVO.getInterest().split(",");
            mav.addObject("interest", interestArr);
        }
        mav.addObject("cVO", cVO);
        mav.addObject("uVO", uVO);
        mav.addObject("pVO", pVO);
        mav.setViewName("users/mypage_comment");
        return mav;
    }

    @GetMapping("mypage/mySendMsg")
    public ModelAndView sendMsg(HttpSession session, PagingVO pVO) {

        ModelAndView mav = new ModelAndView();
        if (!session.getAttribute("LogStatus").equals("Y")) {
            session.setAttribute("msg", "잘못된 접근입니다.");
            mav.setViewName("alert_page");
            return mav;
        }
        if (pVO.getSearchWord() == null) {
            pVO.setSearchWord("");
        }
        pVO.setSearchKey((String) session.getAttribute("LogId"));
        pVO.setTotalRecord(mapper.getTotalSendMsg(pVO));
        pVO.setOnePageRecord(10);
        pVO.setPage(pVO.getPage());

        UserVO uVO = mapper.getUserInfo((String) session.getAttribute("LogId"));
        if (uVO.getInterest() != null) {
            String[] interestArr = uVO.getInterest().split(",");
            mav.addObject("interest", interestArr);
        }
        List<MessageVO> mVO = new ArrayList<MessageVO>();
        mVO = mapper.getSendMsg(pVO);
        mav.addObject("uVO", uVO);
        mav.addObject("pVO", pVO);
        mav.addObject("mVO", mVO);
        System.out.println(pVO);

        mav.setViewName("/users/mypage_sendMsg");
        return mav;
    }

    @GetMapping("mypage/myReceiveMsg")
    public ModelAndView receiveMsg(HttpSession session, PagingVO pVO) {

        ModelAndView mav = new ModelAndView();
        if (!session.getAttribute("LogStatus").equals("Y")) {
            session.setAttribute("msg", "잘못된 접근입니다.");
            mav.setViewName("alert_page");
            return mav;
        }
        if (pVO.getSearchWord() == null) {
            pVO.setSearchWord("");
        }

        pVO.setSearchKey((String) session.getAttribute("LogId"));
        pVO.setOnePageRecord(10);
        pVO.setPage(pVO.getPage());
        pVO.setTotalRecord(mapper.getTotalReceiveMsg(pVO));

        List<MessageVO> mVO = new ArrayList<MessageVO>();
        mVO = mapper.getReceiveMsg(pVO);
        UserVO uVO = mapper.getUserInfo((String) session.getAttribute("LogId"));
        if (uVO.getInterest() != null) {
            String[] interestArr = uVO.getInterest().split(",");
            mav.addObject("interest", interestArr);
        }

        mav.addObject("mVO", mVO);
        mav.addObject("uVO", uVO);
        mav.addObject("pVO", pVO);
        System.out.println(pVO);

        mav.setViewName("/users/mypage_receiveMsg");
        return mav;
    }

    @GetMapping("mypage/submitSubjectSolo")
    public ModelAndView submitSubjectSolo(HttpSession session, PagingVO pVO) {
        ModelAndView mav = new ModelAndView();
        if (pVO.getSearchWord() == null) {
            pVO.setSearchWord("");
        }
        pVO.setSearchKey((String) session.getAttribute("LogId"));
        pVO.setOnePageRecord(4);
        pVO.setPage(pVO.getPage());
        pVO.setTotalRecord(mapper.getSubjectSoloAmount(pVO));

        List<ApplyVO> sVO = mapper.getSubmitSubjectSolo(pVO);
        System.out.println(sVO);
        UserVO uVO = mapper.getUserInfo((String) session.getAttribute("LogId"));
        if (uVO.getInterest() != null) {
            String[] interestArr = uVO.getInterest().split(",");
            mav.addObject("interest", interestArr);
        }
        mav.addObject("pVO", pVO);
        mav.addObject("uVO", uVO);
        mav.addObject("sVO", sVO);

        System.out.println(pVO);
        mav.setViewName("/users/mypage_submitSubjectSolo");
        return mav;
    }

    @GetMapping("mypage/submitSubjectTeam")
    public ModelAndView submitSubjectTeam(HttpSession session, PagingVO pVO) {

        ModelAndView mav = new ModelAndView();
        if (pVO.getSearchWord() == null) {
            pVO.setSearchWord("");
        }
        pVO.setSearchKey((String) session.getAttribute("LogId"));
        pVO.setOnePageRecord(12);
        pVO.setTotalRecord(mapper.getSubjectTeamAmount(pVO));// 이거 다시 계산해줘야함 쿼리문 새로 ㄱㄱ
        pVO.setPage(pVO.getPage());

        pVO.setSearchKey((String) session.getAttribute("LogId"));
        List<ApplyVO> sVO = mapper.getSubmitSubjectTeam(pVO);
        System.out.println(sVO);
        UserVO uVO = mapper.getUserInfo((String) session.getAttribute("LogId"));
        if (uVO.getInterest() != null) {
            String[] interestArr = uVO.getInterest().split(",");
            mav.addObject("interest", interestArr);
        }
        mav.addObject("pVO", pVO);
        mav.addObject("uVO", uVO);
        mav.addObject("sVO", sVO);
        mav.setViewName("/users/mypage_submitSubjectTeam");
        System.out.println(pVO);
        return mav;
    }

    @GetMapping("mypage/pop_sendMsg")
    public String popSendMsg(HttpSession session) {
        String userid = (String) session.getAttribute("LogId");
        return "/users/pop_sendMsg";
    }

    @PostMapping("mypage/pop_sendMsgOk")
    public ModelAndView popsendMsgOk(
            HttpSession session,
            @RequestParam("receive_user") String receiveUser,
            @RequestParam("content") String content) {

        ModelAndView mav = new ModelAndView();
        boardmapper.saveSendMsg((String) session.getAttribute("LogId"), receiveUser, content);
        UserVO uVO = mapper.getUserInfo(receiveUser);
        mav.addObject("uVO", uVO);
        mav.setViewName("/users/pop_sendMsgOk");
        return mav;
    }

    @ResponseBody
    @PostMapping("mypage/checkReceiver")
    public int checkReceiver(String receive_user) {
        UserVO uVO = mapper.getUserInfo(receive_user);
        int result = 1;
        if (uVO == null) {
            result = 0;
        }
        return result;
    }

    @GetMapping("/mypage/leave")
    public ModelAndView leave(HttpSession session) {
        ModelAndView mav = new ModelAndView();

        int result = mapper.deleteUser((String) session.getAttribute("LogId"));
        if (result == 1) {
            session.invalidate();
            session.setAttribute("msg", "탈퇴 성공");
            mav.setViewName("alert_page");
        } else {
            session.setAttribute("msg", "탈퇴 실패");
            mav.setViewName("alert_page");
        }

        return mav;
    }

    @GetMapping("/mypage/biz")
    public ModelAndView mypagebiz(HttpSession session, PagingVO pVO) {
        ModelAndView mav = new ModelAndView();

        pVO.setSearchKey((String) session.getAttribute("LogId"));
        UserVO uVO = mapper.getUserInfo((String) session.getAttribute("LogId"));
        List<SubjectVO> sVO = mapper.SelectSubjectForMypage(pVO);
        System.out.println(sVO);
        mav.addObject("uVO", uVO);
        mav.addObject("sVO", sVO);
        mav.setViewName("/users/mypage_company");
        return mav;
    }
}
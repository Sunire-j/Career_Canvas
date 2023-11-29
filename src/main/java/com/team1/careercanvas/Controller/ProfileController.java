package com.team1.careercanvas.Controller;

import com.team1.careercanvas.mapper.ApplyMapper;
import com.team1.careercanvas.vo.ApplyVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.team1.careercanvas.mapper.PofolMapper;
import com.team1.careercanvas.mapper.UserMapper;
import com.team1.careercanvas.vo.PofolVO;
import com.team1.careercanvas.vo.UserVO;

import java.util.List;

@Controller
public class ProfileController {
	
	private final UserMapper usermapper;
	private final PofolMapper pofolmapper;
	private final ApplyMapper subjectmapper;
	
	public ProfileController(UserMapper usermapper, PofolMapper pofolmapper, ApplyMapper subjectmapper) {
		this.usermapper = usermapper;
		this.pofolmapper = pofolmapper;
		this.subjectmapper = subjectmapper;
	}
	
	@GetMapping("/profile/portfolio")
	public ModelAndView profileInfo(@RequestParam("uid") String userid ) {
		UserVO uservo = usermapper.getUserInfo(userid);
		int pofolamount = pofolmapper.getpofolamount(userid);
		int subjectamount = subjectmapper.getApplyamount(userid);
		List<PofolVO> pofolvo = pofolmapper.getPofolInfo(userid);

		ModelAndView mav =new ModelAndView();
		mav.addObject("uVO", uservo);
		mav.addObject("pCount", pofolamount);
		mav.addObject("pVO", pofolvo);
		mav.addObject("sCount", subjectamount);
		mav.setViewName("users/userProfile");
		
		return mav;
	}

	@GetMapping("/profile/subject/solo")
	public ModelAndView Subject_solo(@RequestParam("uid")String userid){
		UserVO uservo = usermapper.getUserInfo(userid);
		int pofolamount = pofolmapper.getpofolamount(userid);
		List<ApplyVO> subjectvo = subjectmapper.getApplyInfo(userid);
		int subjectamount = subjectmapper.getApplyamount(userid);

		ModelAndView mav = new ModelAndView();
		mav.addObject("pCount", pofolamount);
		mav.addObject("sVO", subjectvo);
		mav.addObject("uVO", uservo);
		mav.addObject("sCount", subjectamount);
		mav.setViewName("users/userProfile_Company_Solo");
		return mav;
	}

	@GetMapping("/profile/subject/party")
	public ModelAndView Subject_party(@RequestParam("uid")String userid){
		UserVO uservo = usermapper.getUserInfo(userid);
		int pofolamount = pofolmapper.getpofolamount(userid);
		List<ApplyVO> subjectvo = subjectmapper.getApplyInfo(userid);
		int subjectamount = subjectmapper.getApplyamount(userid);

		ModelAndView mav = new ModelAndView();
		mav.addObject("pCount", pofolamount);
		mav.addObject("sVO", subjectvo);
		mav.addObject("uVO", uservo);
		mav.addObject("sCount", subjectamount);
		mav.setViewName("users/userProfile_Company_Party");
		return mav;
	}

}

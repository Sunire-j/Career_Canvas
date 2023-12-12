package com.team1.careercanvas.Controller;

import com.team1.careercanvas.mapper.ApplyMapper;
import com.team1.careercanvas.mapper.PofolMapper;
import com.team1.careercanvas.mapper.UserMapper;
import com.team1.careercanvas.vo.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

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
	public ModelAndView profileInfo(@RequestParam("uid") String userid,
									@RequestParam(required = false, defaultValue = "1")int page ) {
		ModelAndView mav =new ModelAndView();

		UserVO uservo = usermapper.getUserInfo(userid);

		if(uservo==null){
			mav.addObject("msg", "잘못된 접근입니다.");
			mav.addObject("isBack",0);
			mav.setViewName("improve_alert");
			return mav;
		}

		int pofolamount = pofolmapper.getpofolamount(userid);
		int subjectamount = subjectmapper.getApplyamountSolo(userid);
		subjectamount+=subjectmapper.getApplyAmountTeam(userid);



		PagingVO pvo = new PagingVO();


		pvo.setOnePageRecord(12);
		pvo.setPage(page);
		pvo.setTotalRecord(pofolamount);
		pvo.setSearchWord(userid);
		


		if(uservo.getUsertype()==1){

			mav.setViewName("redirect:/profile/biz?uid="+userid);

			return mav;
		}
		if(uservo.getInterest()!=null){
			String[] interestArr = uservo.getInterest().split(",");
			mav.addObject("interest", interestArr);
		}
		List<PofolVO> pofolvo = pofolmapper.getPofolInfo(pvo);
		mav.addObject("uVO", uservo);
		mav.addObject("pCount", pofolamount);
		mav.addObject("pVO", pofolvo);
		mav.addObject("PagingVO",pvo);
		mav.addObject("sCount", subjectamount);
		mav.setViewName("users/userProfile");
		
		return mav;
	}

	@GetMapping("/profile/subject/solo")
	public ModelAndView Subject_solo(@RequestParam("uid")String userid,
									 @RequestParam(required = false, defaultValue = "1")int page){

		ModelAndView mav = new ModelAndView();

		UserVO uservo = usermapper.getUserInfo(userid);
		int pofolamount = pofolmapper.getpofolamount(userid);
		int subjectamount = subjectmapper.getApplyamountSolo(userid);

		if(uservo==null){
			mav.addObject("msg", "잘못된 접근입니다.");
			mav.addObject("isBack",0);
			mav.setViewName("improve_alert");
			return mav;
		}

		PagingVO pvo = new PagingVO();


		pvo.setOnePageRecord(12);
		pvo.setPage(page);
		pvo.setTotalRecord(subjectamount);
		pvo.setSearchWord(userid);


		subjectamount+=subjectmapper.getApplyAmountTeam(userid);

		List<ApplyVO> subjectvo = subjectmapper.getApplyInfo(pvo);//<-



		if(uservo.getUsertype()==1){

			mav.setViewName("redirect:/profile/biz?uid="+userid);

			return mav;
		}

		if(uservo.getInterest()!=null){
			String[] interestArr = uservo.getInterest().split(",");
			mav.addObject("interest", interestArr);
		}

		mav.addObject("pCount", pofolamount);
		mav.addObject("sVO", subjectvo);
		mav.addObject("uVO", uservo);
		mav.addObject("PagingVO",pvo);
		mav.addObject("sCount", subjectamount);
		mav.setViewName("users/userProfile_Company_Solo");
		return mav;
	}


	@GetMapping("/profile/subject/party")
	public ModelAndView Subject_party(@RequestParam("uid")String userid,
									  @RequestParam(required = false, defaultValue = "1")int page){
		UserVO uservo = usermapper.getUserInfo(userid);
		int pofolamount = pofolmapper.getpofolamount(userid);
		PagingVO pvo = new PagingVO();
		pvo.setOnePageRecord(12);
		pvo.setPage(page);
		pvo.setTotalRecord(subjectmapper.getApplyAmountTeam(userid));
		pvo.setSearchWord(userid);
		List<ApplyVO> subjectvo = subjectmapper.getApplyInfoTeam(pvo);
		int subjectamount = subjectmapper.getApplyamountSolo(userid);
		subjectamount+=subjectmapper.getApplyAmountTeam(userid);

		ModelAndView mav = new ModelAndView();
		if(uservo==null){
			mav.addObject("msg", "잘못된 접근입니다.");
			mav.addObject("isBack",0);
			mav.setViewName("improve_alert");
			return mav;
		}
		if(uservo.getUsertype()==1){

			mav.setViewName("redirect:/profile/biz?uid="+userid);

			return mav;
		}

		if(uservo.getInterest()!=null){
			String[] interestArr = uservo.getInterest().split(",");
			mav.addObject("interest", interestArr);
		}

		mav.addObject("pCount", pofolamount);
		mav.addObject("sVO", subjectvo);
		mav.addObject("uVO", uservo);
		mav.addObject("PagingVO",pvo);
		mav.addObject("sCount", subjectamount);
		mav.setViewName("users/userProfile_Company_Party");
		return mav;
	}

	@GetMapping("/profile/biz")
	public ModelAndView companyprofile(@RequestParam("uid") String userid,
									   @RequestParam(required = false, defaultValue = "1")int page){
		ModelAndView mav = new ModelAndView();
		UserVO uservo = usermapper.getUserInfo(userid);
		int subjectamount = subjectmapper.getSubjectAmount(userid);

		if(uservo==null){
			mav.addObject("msg", "잘못된 접근입니다.");
			mav.addObject("isBack",0);
			mav.setViewName("improve_alert");
			return mav;
		}

		PagingVO pvo = new PagingVO();

		pvo.setOnePageRecord(12);
		pvo.setPage(page);
		pvo.setTotalRecord(subjectamount);
		pvo.setSearchWord(userid);

		List<SubjectVO> subjectvo = subjectmapper.getSubjectList(pvo);



		if(uservo.getUsertype()!=1){

			mav.setViewName("redirect:/profile/portfolio?uid="+userid);

			return mav;
		}

		mav.addObject("uVO", uservo);
		mav.addObject("sCount", subjectamount);
		mav.addObject("sVO", subjectvo);
		mav.addObject("PagingVO",pvo);

		mav.setViewName("/users/CompanyProfile");
		return mav;
	}
}

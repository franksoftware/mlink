package com.mdc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ManageController {
	
	@RequestMapping("/manage")
	public String manage() {
		return "manage";
	}
}

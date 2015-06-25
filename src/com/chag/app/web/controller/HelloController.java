package com.chag.app.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/test")
public class HelloController {
	@RequestMapping("/hello.do")
	public String find() {
		return "webservice";
	}
}

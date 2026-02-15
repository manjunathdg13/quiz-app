package com.question.question;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
//import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringBootApplication
//@EnableFeignClients
public class QuestionAppApplication {

	public static void main(String[] args) {
		SpringApplication.run(QuestionAppApplication.class, args);
	}

}

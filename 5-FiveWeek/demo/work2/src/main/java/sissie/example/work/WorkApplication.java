package sissie.example.work;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Component;

@SpringBootApplication
public class WorkApplication {

	public static void main(String[] args) {
		// 通过 XML 配置装配 Bean
//		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
//		SgtPeppers sgtPeppers1 = context.getBean(SgtPeppers.class);
//
//		sgtPeppers1.play();

		// 通过注解的方式初始化 Spring IoC 容器
		ApplicationContext context = new AnnotationConfigApplicationContext(playerConfig.class);
		MediaPlayer mediaPlayer = context.getBean("mediaPlayer", CDPlayer.class);
		mediaPlayer.play();

		//SpringApplication.run(WorkApplication.class, args);
	}

}

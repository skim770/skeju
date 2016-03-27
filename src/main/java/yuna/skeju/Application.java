package yuna.skeju;

import org.springframework.boot.autoconfigure.SpringBootApplication;



import org.springframework.boot.SpringApplication;
import org.springframework.context.ApplicationContext;

import java.util.Arrays;

@SpringBootApplication
public class Application {
    
    public static void main(String[] args) {
        ApplicationContext ctx = SpringApplication.run(Application.class, args);

//        System.out.println("This is printed from System.out.println() function.");
//
       String[] beanNames = ctx.getBeanDefinitionNames();
        Arrays.sort(beanNames);
        for (String beanName : beanNames) {
            //System.out.println(beanName);
        }
    }

}
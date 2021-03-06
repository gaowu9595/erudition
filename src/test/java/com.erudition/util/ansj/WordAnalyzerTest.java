package com.erudition.util.ansj;

import com.erudition.util.TextRead;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.ContextHierarchy;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by sl on 16-8-21.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration(value = "src/main/webapp")
@ContextHierarchy({
        @ContextConfiguration(name = "parent", locations = "classpath*:conf/spring.xml"),
        @ContextConfiguration(name = "child", locations = "classpath*:conf/springmvc.xml")
})
public class WordAnalyzerTest {

        @Test
        public void testCount(){
                WordAnalyzer wordAnalyzer = new WordAnalyzer();

                TextRead textRead = new TextRead();

                String words = textRead.getStringFromWord("/home/sl/test1.doc");

                try {
                        String word1 = wordAnalyzer.count(words,5);

                } catch (IOException e) {
                        e.printStackTrace();
                }

        }


}

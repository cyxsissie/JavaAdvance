package sissie.example.work;

import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import javax.annotation.Resource;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.SQLException;


@RunWith(SpringRunner.class)
@SpringBootTest()
@ContextConfiguration(locations = { "classpath*:*.xml"})

class WorkApplicationTests {

	/**
	 * Spring Boot 默认已经配置好了数据源，程序员可以直接 DI 注入然后使用即可
	 */
	@Resource
	DataSource dataSource;
	@Test
	public void contextLoads() throws SQLException {
		Connection connection = dataSource.getConnection();
		DatabaseMetaData metaData = connection.getMetaData();

		//数据源>>>>>>class com.zaxxer.hikari.HikariDataSource
		System.out.println("数据源>>>>>>" + dataSource.getClass());
		System.out.println("连接>>>>>>>>" + connection);
		System.out.println("连接地址>>>>" + connection.getMetaData().getURL());
		System.out.println("驱动名称>>>>" + metaData.getDriverName());
		System.out.println("驱动版本>>>>" + metaData.getDriverVersion());
		System.out.println("数据库名称>>" + metaData.getDatabaseProductName());
		System.out.println("数据库版本>>" + metaData.getDatabaseProductVersion());
		System.out.println("连接用户名称>" + metaData.getUserName());

		connection.close();

	}

}

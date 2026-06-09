package com.db;

import java.util.Properties;

import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.AvailableSettings;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;

import com.entity.Expense;
import com.entity.User;

public class HibernateUtil {

	private static SessionFactory sessionFactory;

	public static SessionFactory getSessionFactory() {
		if (sessionFactory == null) {
			Configuration configuration = new Configuration();

			Properties properties = new Properties();
			properties.put(AvailableSettings.DRIVER, "com.mysql.cj.jdbc.Driver");
			properties.put(AvailableSettings.URL, "jdbc:mysql://localhost:3306/expense_tracker_db");
			properties.put(AvailableSettings.USER, "root");
			properties.put(AvailableSettings.PASS, "Luffy@2004");
			properties.put(AvailableSettings.DIALECT, "org.hibernate.dialect.MySQL8Dialect");
			properties.put(AvailableSettings.HBM2DDL_AUTO, "update");
			properties.put(AvailableSettings.SHOW_SQL, true);

			configuration.setProperties(properties);
			configuration.addAnnotatedClass(User.class);
			configuration.addAnnotatedClass(Expense.class);

			ServiceRegistry serviceRegistery = new StandardServiceRegistryBuilder()
					.applySettings(configuration.getProperties()).build();

			sessionFactory = configuration.buildSessionFactory(serviceRegistery);

		}
		return sessionFactory;
	}
}

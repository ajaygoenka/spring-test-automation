package com.experian.test.utils.file.props;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

public class PropertyFileReader {
	
	private Properties properties;

	public PropertyFileReader loadPropFile(String filePath) {
		FileInputStream inputFile = null;
		try {
			inputFile = new FileInputStream(filePath);
			properties = new Properties();
			properties.load(inputFile);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		try {
			inputFile.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return this;
	}
	
	public Properties getProperties() {
		return properties;
	}

	public String getValue(String key) {
		return properties.getProperty(key);
	}

}

package com.auto.test.utils.file;

import com.amazonaws.util.IOUtils;
import com.auto.test.utils.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;

public class FileUtils {
	
	private static final Logger log = (Logger) LoggerFactory.getLogger(FileUtils.class);

	public static String loadFile(String fileName) throws IOException {
		if (StringUtils.isNotNullOrEmpty(fileName)) {
			InputStream input = FileUtils.class.getResourceAsStream(fileName);
			return IOUtils.toString(input);
		}
		throw new IllegalArgumentException("[FileUtils] Defined file name is NULL or empty!");
	}
	
	public static File getFile(String filePath) {
		if (StringUtils.isNotNullOrEmpty(filePath))
			return new File(filePath);
		throw new IllegalArgumentException("[FileUtils] Defined file path is NULL or empty!");
	}

	public static boolean doesFileExist(String filePath) {
		File file = getFile(filePath);
		if (file.exists() && !file.isDirectory())
			return true;
		return false;
	}
	
	public static boolean doesFileExist(File file) {
		if (file.exists() && !file.isDirectory())
			return true;
		return false;
	}

	public static File createFile(String filePath) {
		File file = getFile(filePath);
		if (!doesFileExist(file)) {
			try {
				file.createNewFile();
				log.info("[FileUtils] New file created: [" + filePath + "].");
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else 
			log.warn("[FileUtils] File [" + filePath + "] is NOT created: file already exists!");
		return file;
	}
	  
	public static void deleteFile(String filePath) {
		File file = getFile(filePath);
		if (doesFileExist(file)) {
			file.delete();
			log.info("[FileUtils] File deleted: [" + filePath + "].");
		} else
			log.warn("[FileUtils] File [" + filePath + "] is NOT deleted: file NOT found!");
	}
	
	public static void writeToFile(String filePath, byte[] content) {
		FileOutputStream fos = null;
		try {
			fos = new FileOutputStream(getFile(filePath));
			fos.write(content);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		try {
			fos.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
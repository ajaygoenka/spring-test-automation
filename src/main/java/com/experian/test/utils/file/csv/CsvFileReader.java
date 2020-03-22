package com.experian.test.utils.file.csv;

import au.com.bytecode.opencsv.CSVReader;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class CsvFileReader {
	
	public static List<String[]> readCsv(String csvFilePath) {
		
		List<String[]> data = new ArrayList<String[]>();
		CSVReader reader = null;
		
        try {
        	reader = new CSVReader(new FileReader(new File(csvFilePath)));
			data = reader.readAll();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (reader != null)
				try {
					reader.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
		}
		return data;
	}
}

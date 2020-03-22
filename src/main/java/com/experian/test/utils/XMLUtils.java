package com.experian.test.utils;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.io.SAXReader;

import java.io.File;

public class XMLUtils {

    public static Document readXMLFile(String filename) {
        Document xmlDocument = null;
        File inputFile = new File(filename);
        SAXReader reader = new SAXReader();

        try {
            xmlDocument = reader.read(inputFile);
        } catch (DocumentException e) {
            e.printStackTrace();
        }

        return xmlDocument;
    }

    public static Document readXMLString(String xmlString) {
        Document xmlDocument = null;
        SAXReader reader = new SAXReader();

        try {
            xmlDocument = reader.read(xmlString);
        } catch (DocumentException e) {
            e.printStackTrace();
        }

        return xmlDocument;
    }

    public static String getNode(Document xmlDocument, String pathToNode) {
        return String.valueOf(xmlDocument.selectSingleNode(pathToNode));
    }

}

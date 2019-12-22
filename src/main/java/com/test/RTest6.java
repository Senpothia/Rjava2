package com.test;

import java.awt.List;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.rosuda.JRI.Rengine;

public class RTest6 {

	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub

		//Runtime.getRuntime().exec("Rscript kaplanMeier.r");
		Regression regression = new Regression();
		regression.start();
		
		new Thread(new Analyse()).start();
		
		/**
		String uri = "reg.csv";
		Path path = Paths.get(uri);
		//List <String> lines = Files.readAllLines(path);
		java.util.List<String> lines = Files.readAllLines(path);
		for (int i = 1; i < lines.size(); i++) {
			System.out.println(lines.get(i));
		}
		
	*/
		
		System.out.println("End");
		}
		
	}

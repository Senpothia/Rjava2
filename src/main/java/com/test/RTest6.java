package com.test;

import java.awt.List;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.rosuda.JRI.Rengine;

public class RTest6 {

	public static void main(String[] args) throws IOException, InterruptedException {
		// TODO Auto-generated method stub

		//Runtime.getRuntime().exec("Rscript kaplanMeier.r");
		
		
		Temoin temoin = new Temoin();
		Regression regression = new Regression(temoin);
		//Analyse analyse = new Analyse(temoin);
		
		//new Thread(regression).start();
		//new Thread(analyse).start();
		Thread t1 = new Thread(regression);
		t1.start();
		//Thread t2 = new Thread(analyse);
		
		t1.join();
		String uri = "reg.csv";
		Path path = Paths.get(uri);
		//List <String> lines = Files.readAllLines(path);
		java.util.List<String> lines = Files.readAllLines(path);
		for (int i = 1; i < lines.size(); i++) {
			System.out.println(lines.get(i));
		}
		
		 
		
		System.out.println("End");
		}
		
	}

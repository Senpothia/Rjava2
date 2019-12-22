package com.test;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class Analyse extends Thread {

	public Temoin temoin = new Temoin();

	public Analyse(Temoin temoin) {

		this.temoin = temoin;

	}

	public void run() {

		synchronized (this.temoin) {
			
			
			System.out.println("Thread Analyse en cours");
			String uri = "reg.csv";
			Path path = Paths.get(uri);
			// List <String> lines = Files.readAllLines(path);
			java.util.List<String> lines = null;

			try {
				lines = Files.readAllLines(path);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			for (int i = 1; i < lines.size(); i++) {
				System.out.println(lines.get(i));

			}

		}
		System.out.println("FIN Thread Analyse");
	}
}

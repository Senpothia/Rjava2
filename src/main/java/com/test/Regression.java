package com.test;

import java.io.IOException;

public class Regression extends Thread{
	
	public void run(){
		
		try {
			
			System.out.println("Thread R en cours");
			Runtime.getRuntime().exec("Rscript regression.r");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}

package com.test;

import java.io.IOException;

public class Ggplot2 extends Thread {
	
public Temoin temoin;
	
	public Ggplot2 (Temoin temoin)  {
		
		this.temoin = temoin;
	}
	
	
	public void run(){
		
		synchronized (this.temoin) {
			
			try {
				
				System.out.println("Thread R en cours");
				Runtime.getRuntime().exec("Rscript ggplot2.r");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				sleep(500);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("FIN Thread R");
		}
		
	}

}

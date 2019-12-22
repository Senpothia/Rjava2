package com.test;

import java.io.IOException;

public class Mle5 extends Thread{
	
public Temoin temoin;
	
	public Mle5 (Temoin temoin)  {
		
		this.temoin = temoin;
	}
	
	
	public void run(){
		
		synchronized (this.temoin) {
			
			try {
				
				System.out.println("Thread R en cours");
				Runtime.getRuntime().exec("Rscript MLE5.r");
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

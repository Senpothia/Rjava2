package com.test;

import java.io.IOException;

import org.rosuda.JRI.Rengine;

public class RTest6 {

	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub

		Runtime.getRuntime().exec("Rscript regression.r");
		System.out.println("End");
	}

}
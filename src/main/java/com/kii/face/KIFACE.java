package com.kii.face;

import java.io.File;
import java.io.FileInputStream;

public class KIFACE {
	/*
	 * Static Library Load
	 */
	public static boolean isInit = false;

	/*
	 * static { System.loadLibrary("KIFACE"); }
	 */

	/**
	 * �� �̹����� ���� ��θ� �Է¹ް�, byteArray�� ��ȯ�Ͽ� KiiMatch �¿� ��, Score�� ���� �޾� �縮��.
	 * 
	 * @param imgPath1
	 * @param imgPath2
	 * @return matchingScore
	 */
	public int convertImageToByteArray(String imgPath1, String imgPath2) {

		System.out.println(imgPath1);
		System.out.println(imgPath2);

		File enrollmentFile = new File(imgPath1);
		File attemptFile = new File(imgPath2);

		byte[] enrollment = new byte[(int) enrollmentFile.length()];
		byte[] attempt = new byte[(int) attemptFile.length()];

		System.out.println(enrollment);
		System.out.println(attempt);
		System.out.println((int) enrollmentFile.length() + "/"
				+ (int) attemptFile.length());

		FileInputStream fis = null;
		try {
			fis = new FileInputStream(enrollmentFile);
			fis.read(enrollment);
			fis.close();
			if (enrollment != null)
				System.out.println("\n\n EnrollmentFile Converted.");

			fis = new FileInputStream(attemptFile);
			fis.read(attempt);
			fis.close();
			if (attempt != null)
				System.out.println("\n\n AttemptFile Converted.");
		} catch (Exception e) {
			System.out.println("Exception" + e);
		}

		return 0;
	}

	public KIFACE() {

	}

	public KIFACE(String path) {
		if (isInit == true) {
			return;
		}

		KiiInit(path);
		isInit = true;
	}

	public native int KiiInit(String path);

	public native int KiiMatch(byte[] enrollment, byte[] attempt);
}

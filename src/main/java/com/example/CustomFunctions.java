package com.example;

public class CustomFunctions {
	public static String truncateWithEllipsis(String content, int maxLength) {
		if (content == null || content.length() <= maxLength) {
			return content;
		}

		// Find the last space within the limit
		int lastSpaceIndex = content.lastIndexOf(' ', maxLength);
		if (lastSpaceIndex == -1) {
			return content.substring(0, maxLength) + "...";
		} else {
			return content.substring(0, lastSpaceIndex) + "...";
		}
	}
}

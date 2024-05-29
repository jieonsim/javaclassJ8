package archive.guestBook;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import archive.ArchiveInterface;
import record.guestBook.GuestBookDAO;

public class DeleteGuestBookCommand implements ArchiveInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GuestBookDAO guestBookDAO = new GuestBookDAO();
		
		
		
	}
}

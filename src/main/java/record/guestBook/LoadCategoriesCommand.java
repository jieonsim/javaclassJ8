package record.guestBook;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import place.CategoryDAO;
import place.CategoryVO;

public class LoadCategoriesCommand implements GuestBookInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CategoryDAO categoryDAO = new CategoryDAO();
		List<CategoryVO> categories = categoryDAO.getAllCategories();

		Map<String, List<CategoryVO>> categoriesByType = new HashMap<>();
		for (CategoryVO category : categories) {
			categoriesByType.computeIfAbsent(category.getCategoryType(), k -> new ArrayList<>()).add(category);
		}

		request.setAttribute("categoriesByType", categoriesByType);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/record/addANewPlaceModal.jsp");
		dispatcher.forward(request, response);
	}
}

package record.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import place.CategoryDAO;
import place.CategoryVO;

public class LoadCategoriesHelper {

    public static void loadCategories(HttpServletRequest request) {
        CategoryDAO categoryDAO = new CategoryDAO();
        List<CategoryVO> categories = categoryDAO.getAllCategories();

        Map<String, List<CategoryVO>> categoriesByType = new HashMap<>();
        for (CategoryVO category : categories) {
            categoriesByType.computeIfAbsent(category.getCategoryType(), k -> new ArrayList<>()).add(category);
        }

        request.setAttribute("categoriesByType", categoriesByType);
    }
}

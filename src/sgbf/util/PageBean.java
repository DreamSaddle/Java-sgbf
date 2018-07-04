package sgbf.util;

import java.util.List;

/**
 * 分页工具类
 * @param <T>
 */
public class PageBean<T> {

    /*分页参数*/
    private int currentPage = 1;  //当前页，默认显示第一页
    private int pageCount = 12;  //每页显示行数，默认显示9行
    private int totalCount;  //数据总记录数
    private int totalPage;  //总页数 = 总记录数 / 每页显示行数(+1 单数要加1页)
    private List<T> pageData;  //分页查询到的数据

    /*
    返回总页数
     */
    public int getTotalPage() {
        if (totalCount % pageCount == 0)
            totalPage = totalCount / pageCount;
        else
            totalPage = totalCount / pageCount + 1;

        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getPageCount() {
        return pageCount;
    }

    public void setPageCount(int pageCount) {
        this.pageCount = pageCount;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }

    public List<T> getPageData() {
        return pageData;
    }

    public void setPageData(List<T> pageData) {
        this.pageData = pageData;
    }
}

package com.cqyit.learning.controller;

import com.cqyit.learning.common.utils.ResultUtil;
import com.cqyit.learning.common.utils.TokenUtil;
import com.cqyit.learning.pojo.Notebook;
import com.cqyit.learning.pojo.NotebookClass;
import com.cqyit.learning.pojo.User;
import com.cqyit.learning.service.INotebookService;
import com.cqyit.learning.service.IUserService;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.List;
import java.util.Objects;

/**
 * @author MrHee
 * @version 1.0
 * @className: NotebookController
 * @date 2023/11/9 13:05
 * @description:
 */
@RestController
@RequestMapping("/notebook")
public class NotebookController {
    @Resource
    private INotebookService notebookService;
    @Resource
    private IUserService userService;

    @GetMapping("/list")
    public ResultUtil<List<Notebook>> getNotebookList(@RequestHeader("Authorization") String token) {
        User user = new TokenUtil().getUser(userService, token);
        List<Notebook> notebook = notebookService.getUserNotebook(user.getId());
        return new ResultUtil<>(notebook);
    }

    @GetMapping("/class")
    public ResultUtil<List<NotebookClass>> getNotebookClassList(@RequestHeader("Authorization") String token) {
        User user = new TokenUtil().getUser(userService, token);
        List<NotebookClass> notebookClass = notebookService.getUserNotebookClass(user.getId());
        return new ResultUtil<>(notebookClass);
    }

    @GetMapping("/detail")
    public ResultUtil<Notebook> getNotebook(@RequestParam Integer bookId, @RequestHeader("Authorization") String token) {
        Notebook notebookDetail = notebookService.getNotebookDetail(bookId.longValue());
        User user = new TokenUtil().getUser(userService, token);
        if (notebookDetail.getOtherVisit() == 0 && !Objects.equals(user.getId(), notebookDetail.getUserId())) {
            return new ResultUtil<>(); //无权查看
        }
        return new ResultUtil<>(notebookDetail);
    }

    @PostMapping("/add")
    public ResultUtil<Boolean> addNotebook(@RequestBody Notebook notebook, @RequestHeader("Authorization") String token) {
        User user = new TokenUtil().getUser(userService, token);
        notebook.setUserId(user.getId());
        return new ResultUtil<>(notebookService.insertNotebook(notebook));
    }

    @PostMapping("/add/class")
    public ResultUtil<Boolean> addNotebookClass(@RequestBody String title, @RequestHeader("Authorization") String token) {
        User user = new TokenUtil().getUser(userService, token);
        NotebookClass notebookClass = new NotebookClass();
        String substring = title.substring(1, title.length() - 1);
        notebookClass.setTitle(substring);
        notebookClass.setUserId(user.getId());
        return new ResultUtil<>(notebookService.insertNotebookClass(notebookClass));
    }

    @PutMapping("/update")
    public ResultUtil<Boolean> updateNotebook(@RequestBody Notebook notebook, @RequestHeader("Authorization") String token) {
        Notebook notebookDetail = notebookService.getNotebookDetail(notebook.getId());
        User user = new TokenUtil().getUser(userService, token);
        if (!Objects.equals(notebookDetail.getUserId(), user.getId())) {
            return new ResultUtil<>(301, "没有权限");
        }
        return new ResultUtil<>(notebookService.updateNotebook(notebook));
    }

    @PutMapping("/update/class")
    public ResultUtil<Boolean> updateNotebookClass(@RequestBody NotebookClass notebookClass, @RequestHeader("Authorization") String token) {
        NotebookClass notebookClassDetail = notebookService.getNotebookClassDetail(notebookClass.getId());
        User user = new TokenUtil().getUser(userService, token);
        if (!Objects.equals(notebookClassDetail.getUserId(), user.getId())) {
            return new ResultUtil<>(301, "没有权限");
        }
        return new ResultUtil<>(notebookService.updateNotebookClass(notebookClass));
    }

    @DeleteMapping("/delete/{id}")
    public ResultUtil<Boolean> deleteNotebook(@RequestHeader("Authorization") String token, @PathVariable Integer id) {
        Notebook notebookDetail = notebookService.getNotebookDetail(id.longValue());
        User user = new TokenUtil().getUser(userService, token);
        if (!Objects.equals(notebookDetail.getUserId(), user.getId())) {
            return new ResultUtil<>(301, "没有权限");
        }
        return new ResultUtil<>(notebookService.deleteNotebook(id.longValue()));
    }

    @DeleteMapping("/delete/class/{id}")
    public ResultUtil<Boolean> deleteNotebookClass(@PathVariable Integer id, @RequestHeader("Authorization") String token) {
        NotebookClass notebookClassDetail = notebookService.getNotebookClassDetail(id.longValue());
        User user = new TokenUtil().getUser(userService, token);
        if (!Objects.equals(notebookClassDetail.getUserId(), user.getId())) {
            return new ResultUtil<>(301, "没有权限");
        }
        return new ResultUtil<>(notebookService.deleteNotebookClass(id.longValue()));
    }
}

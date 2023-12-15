package com.cqyit.learning.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.cqyit.learning.pojo.Notebook;
import com.cqyit.learning.pojo.NotebookClass;

import java.util.List;

/**
 * @author MrHee
 * @version 1.0
 * @interfaceName: INotebookService
 * @date 2023/11/9 12:56
 * @description:
 */
public interface INotebookService extends IService<Notebook> {
    List<Notebook> getUserNotebook(Long userId);

    List<NotebookClass> getUserNotebookClass(Long userId);

    Notebook getNotebookDetail(Long notebookId);

    NotebookClass getNotebookClassDetail(Long notebookClassId);

    boolean insertNotebook(Notebook notebook);

    boolean updateNotebook(Notebook notebook);

    boolean deleteNotebook(Long notebookId);

    boolean insertNotebookClass(NotebookClass notebookClass);

    boolean updateNotebookClass(NotebookClass notebookClass);

    boolean deleteNotebookClass(Long notebookClassId);
}

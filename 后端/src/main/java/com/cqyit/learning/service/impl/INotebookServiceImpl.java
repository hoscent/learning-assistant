package com.cqyit.learning.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cqyit.learning.dao.NotebookClassDao;
import com.cqyit.learning.dao.NotebookDao;
import com.cqyit.learning.pojo.Notebook;
import com.cqyit.learning.pojo.NotebookClass;
import com.cqyit.learning.service.INotebookService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author MrHee
 * @version 1.0
 * @className: INotebookServiceImpl
 * @date 2023/11/9 12:57
 * @description:
 */
@Service
public class INotebookServiceImpl extends ServiceImpl<NotebookDao, Notebook> implements INotebookService {
    @Resource
    private NotebookDao notebookDao;
    @Resource
    private NotebookClassDao notebookClassDao;

    @Override
    public List<Notebook> getUserNotebook(Long userId) {
        LambdaQueryWrapper<Notebook> lqw = new LambdaQueryWrapper<>();
        lqw.eq(Notebook::getUserId, userId);
        lqw.orderByDesc(Notebook::getGmtModified);
        return notebookDao.selectList(lqw);
    }

    @Override
    public List<NotebookClass> getUserNotebookClass(Long userId) {
        LambdaQueryWrapper<NotebookClass> lqw = new LambdaQueryWrapper<>();
        lqw.eq(NotebookClass::getUserId, userId);
        return notebookClassDao.selectList(lqw);
    }

    @Override
    public Notebook getNotebookDetail(Long notebookId) {
        Notebook notebook = notebookDao.selectById(notebookId);
        if (notebook.getCategoryId() > 0) {
            NotebookClass notebookClass = notebookClassDao.selectById(notebook.getCategoryId());
            notebook.setNotebookClass(notebookClass);
        }
        return notebook;
    }

    @Override
    public NotebookClass getNotebookClassDetail(Long notebookClassId) {
        return notebookClassDao.selectById(notebookClassId);
    }

    @Override
    public boolean insertNotebook(Notebook notebook) {
        return notebookDao.insert(notebook) > 0;
    }

    @Override
    public boolean updateNotebook(Notebook notebook) {
        if (notebook.getId() > 0) {
            return notebookDao.updateById(notebook) > 0;
        }
        return false;
    }

    @Override
    public boolean deleteNotebook(Long notebookId) {
        if (notebookId > 0) {
            return notebookDao.deleteById(notebookId) > 0;
        }
        return false;
    }

    @Override
    public boolean insertNotebookClass(NotebookClass notebookClass) {
        return notebookClassDao.insert(notebookClass) > 0;
    }

    @Override
    public boolean updateNotebookClass(NotebookClass notebookClass) {
        if (notebookClass.getId() > 0) {
            return notebookClassDao.updateById(notebookClass) > 0;
        }
        return false;
    }

    @Override
    public boolean deleteNotebookClass(Long notebookClassId) {
        if (notebookClassId > 0) {
            return notebookClassDao.deleteById(notebookClassId) > 0;
        }
        return false;
    }
}

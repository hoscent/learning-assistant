package com.cqyit.learning.controller;

import com.cqyit.learning.common.utils.ResultUtil;
import com.cqyit.learning.common.utils.TokenUtil;
import com.cqyit.learning.pojo.History;
import com.cqyit.learning.pojo.User;
import com.cqyit.learning.service.IHistoryService;
import com.cqyit.learning.service.IUserService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Map;

/**
 * @author MrHee
 * @version 1.0
 * @className: HistoryController
 * @date 2023/10/27 17:39
 * @description:
 */
@RestController
@RequestMapping("/history")
public class HistoryController {
    @Resource
    private IHistoryService historyService;
    @Resource
    private IUserService userService;

    @PostMapping("/add")
    public ResultUtil<String> getHistory(@RequestBody Map<String, Integer> map, @RequestHeader("Authorization") String token) {
        User user = new TokenUtil().getUser(userService, token);
        Long targetId = map.get("targetId").longValue();
        Integer type = map.get("type");
        History history = new History();
        history.setUserId(user.getId());
        history.setTargetId(targetId);
        history.setTypeId(type);
        historyService.insertHistory(history);
        return new ResultUtil<>();
    }

    @GetMapping("/num")
    public ResultUtil<Integer> getHistoryNum(@RequestParam Integer targetId, @RequestParam Integer type) {
        return new ResultUtil<>(historyService.countHistory(targetId.longValue(), type));
    }
}

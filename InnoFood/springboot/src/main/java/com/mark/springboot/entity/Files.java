package com.mark.springboot.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Files {
    private Integer id;
    private String name;
    private String type;
    private Long size;
    private String psrc;
    private Boolean isDelete;
    private Boolean enable;
}

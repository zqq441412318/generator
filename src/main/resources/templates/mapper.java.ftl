package ${package.Mapper};

import ${package.Entity}.${entity};
import ${superMapperClassPackage};
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author ${author}
 * @since ${date}
 */
public interface ${table.mapperName} extends ${superMapperClass}<${entity}> {

<#if cfg.findById>
    /**
     * 根据id查询
     * @param id
     * @return ${entity}
     */
    ${entity} findById(@Param("id")String id);
</#if>

<#if cfg.deleteById>
    /**
     * 根据id删除
     * @param id
     */
    int deleteById(@Param("id")String id);
</#if>

<#if cfg.updateById>
    /**
     * 修改
     * @param ${entity?uncap_first}
     */
    int updateById(${entity} ${entity?uncap_first});
</#if>

<#if cfg.insert>
    /**
     * 插入
     * @param ${entity?uncap_first}
     */
    int insert(${entity} ${entity?uncap_first});
</#if>

<#if cfg.insertBatch>
    /**
     * 批量插入
     * @param list
     */
    int insertBatch(@Param("list")List<${entity}> list);
</#if>

<#if cfg.updateBatch>
     /**
      * 批量修改
      * @param list
      */
     void updateBatch(@Param("list")List<${entity}> list);
</#if>

}


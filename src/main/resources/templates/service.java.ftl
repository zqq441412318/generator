package ${package.Service};

import ${package.Entity}.${entity};
import ${superServiceClassPackage};

import java.util.List;

/**
 * @author ${author}
 * @since ${date}
 */
public interface ${table.serviceName} extends ${superServiceClass}<${entity}> {

<#if cfg.findById>
    /**
     * 根据id查询
     * @param id
     * @return ${entity}
     */
    ${entity} findById(String id);
</#if>

<#if cfg.deleteById>
    /**
     * 根据id删除
     * @param id
     */
    void deleteById(String id);
</#if>

<#if cfg.updateById>
    /**
     * 修改
     * @param ${entity?uncap_first}
     */
    void update${entity}(${entity} ${entity?uncap_first});
</#if>

<#if cfg.insert>
    /**
     * 插入
     * @param ${entity?uncap_first}
     */
    void insert(${entity} ${entity?uncap_first});
</#if>

<#if cfg.insertBatch>
   /**
    * 批量插入
    * @param list
    */
   void insertBatch(List<${entity}> list);
</#if>

<#if cfg.updateBatch>
    /**
     * 批量修改
     * @param list
     */
    void updateBatch(List<${entity}> list);
</#if>

}


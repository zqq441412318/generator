package ${package.ServiceImpl};

import ${package.Entity}.${entity};
import ${package.Mapper}.${table.mapperName};
import ${package.Service}.${table.serviceName};
import ${superServiceImplClassPackage};
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author ${author}
 * @since ${date}
 */
@Service
public class ${table.serviceImplName} extends ${superServiceImplClass}<${table.mapperName}, ${entity}> implements ${table.serviceName} {

<#if cfg.findById>
    @Override
    public ${entity} findById(String id) {
       return getBaseMapper().findById(id);
    }
</#if>

<#if cfg.findById>
    @Override
    public void deleteById(String id) {
       getBaseMapper().deleteById(id);
    }
</#if>

<#if cfg.updateById>
    @Override
    public void update${entity}(${entity} ${entity?uncap_first}) {
       getBaseMapper().updateById(${entity?uncap_first});
    }
</#if>

<#if cfg.insert>
    @Override
    public void insert(${entity} ${entity?uncap_first}) {
       getBaseMapper().insert(${entity?uncap_first});
    }
</#if>

<#if cfg.insertBatch>
   @Override
   public void insertBatch(List<${entity}> list) {
      getBaseMapper().insertBatch(list);
   }
</#if>

<#if cfg.updateBatch>
   @Override
   public void updateBatch(List<${entity}> list) {
      getBaseMapper().updateBatch(list);
   }
</#if>
}


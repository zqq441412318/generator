<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${package.Mapper}.${table.mapperName}">

    <!-- 通用查询映射结果 -->
    <resultMap id="BaseResultMap" type="${package.Entity}.${entity}">
    <#--设置主键字段名默认为id-->
    <#assign primary_key = "id"/>
    <#--实体里对应的id主键-->
    <#assign property_id = "id"/>
    <#list table.fields as field>
        <#--生成主键-->
        <#if field.keyFlag>
        <#--设置主键-->
        <#assign primary_key = "${field.name}"/>
        <#assign property_id = "${field.propertyName}"/>
        <id column="${field.name}" property="${field.propertyName}" />
        </#if>
    </#list>
    <#list table.fields as field>
        <#--生成字段 -->
        <#if !field.keyFlag>
        <result column="${field.name}" property="${field.propertyName}" />
        </#if>
    </#list>
    </resultMap>

    <!-- 通用查询结果列 -->
    <sql id="Base_Column_List">
        ${table.fieldNames}
    </sql>

<#--根据id查询-->
<#if cfg.findById>
    <select id="findById" resultMap="BaseResultMap" parameterType="java.lang.String">
        select
        <include refid="Base_Column_List"/>
        from ${table.name} where ${primary_key} = #<#noparse>{</#noparse>id}
    </select>
</#if>

<#--根据id删除-->
<#if cfg.deleteById>
    <delete id="deleteById" parameterType="java.lang.String">
        delete from ${table.name} where ${primary_key} = #<#noparse>{</#noparse>id}
    </delete>
</#if>

<#--根据id修改-->
<#if cfg.updateById>
    <update id="updateById" parameterType="${package.Entity}.${entity}">
        update ${table.name}
        <set>
        <#list table.fields as field>
        <#if !field.keyFlag>
            <if test="${field.propertyName} != null<#if field.propertyType == 'String'> and ${field.propertyName} != ''</#if>">
                ${field.name} = #<#noparse>{</#noparse>${field.name}},
            </if>
        </#if>
        </#list>
        </set>
        where ${primary_key} = #<#noparse>{</#noparse>id}
    </update>
</#if>

<#--插入-->
<#if cfg.insert>
    <insert id="insert" parameterType="${package.Entity}.${entity}">
        insert into ${table.name}
        (
        <#list table.fields as field>
            ${field.name}<#if field_has_next>,</#if>
        </#list>
        ) values
        (
        <#list table.fields as field>
           #<#noparse>{</#noparse>${field.propertyName}}<#if field_has_next>,</#if>
        </#list>
        )
    </insert>
</#if>

<#if cfg.insertBatch>
    <insert id="insertBatch">
        insert into ${table.name}
        (
        <#list table.fields as field>
            ${field.name}<#if field_has_next>,</#if>
        </#list>
        ) values
        <foreach collection="list" item="item" separator=",">
            (
            <#list table.fields as field>
                #<#noparse>{item.</#noparse>${field.propertyName}}<#if field_has_next>,</#if>
            </#list>
            )
        </foreach>
    </insert>
</#if>

<#--批量修改-->
<#if cfg.updateBatch>
    <update id="updateBatch">
        update ${table.name}
        <set>
        <#list table.fields as field>
            <#if !field.keyFlag>
            <foreach collection="list" item="item" open="${field.name} = ( case" close="end)<#if field_has_next>,</#if>">
                when ${primary_key} = #<#noparse>{item.</#noparse>${property_id}} then
                <choose>
                    <when test="item.${field.propertyName} == null">
                         ${field.name}
                    </when>
                    <otherwise>
                         #<#noparse>{item.</#noparse>${field.propertyName}}
                    </otherwise>
                </choose>
            </foreach>
            </#if>
        </#list>
        </set>
        where ${primary_key} in
        <foreach collection="list" item="item" open="(" close=")" separator=",">
            #<#noparse>{item.</#noparse>${property_id}}
        </foreach>
    </update>
</#if>
</mapper>

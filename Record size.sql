-- Found at: https://dba.stackexchange.com/questions/25531/how-can-i-get-the-actual-data-size-per-row-in-a-sql-server-table

declare @table nvarchar(128)
declare @idcol nvarchar(128)
declare @sql nvarchar(max)

--initialize those two values
set @table = 'tbl'
set @idcol = 'ROWID'

set @sql = 'select ' + @idcol +' , (0'

select @sql = @sql + ' + isnull(datalength(' + QUOTENAME(name) + '), 1)' 
        from  sys.columns 
        where object_id = object_id(@table)
        and   is_computed = 0
set @sql = @sql + ') as rowsize from ' + @table + ' order by rowsize desc'

PRINT @sql

exec (@sql)

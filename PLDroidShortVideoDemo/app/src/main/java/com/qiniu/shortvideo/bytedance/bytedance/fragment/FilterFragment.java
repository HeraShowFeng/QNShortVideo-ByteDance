// Copyright (C) 2018 Beijing Bytedance Network Technology Co., Ltd.
package com.qiniu.shortvideo.bytedance.bytedance.fragment;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;


import com.qiniu.shortvideo.bytedance.R;
import com.qiniu.shortvideo.bytedance.activity.VideoRecordActivity;
import com.qiniu.shortvideo.bytedance.bytedance.adapter.FilterRVAdapter;
import com.qiniu.shortvideo.bytedance.bytedance.contract.FilterContract;
import com.qiniu.shortvideo.bytedance.bytedance.contract.presenter.FilterPresenter;

import java.io.File;

/**
 * 滤镜
 */
public class FilterFragment extends BaseFeatureFragment<FilterContract.Presenter, FilterFragment.IFilterCallback>
        implements FilterRVAdapter.OnItemClickListener, EffectFragment.IProgressCallback,
        VideoRecordActivity.OnCloseListener, FilterContract.View {
    private RecyclerView rv;

    public interface IFilterCallback {
        void onFilterSelected(File file);
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        rv = (RecyclerView) View.inflate(getContext(), R.layout.fragment_filter, null);
        return rv;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        setPresenter(new FilterPresenter());

        FilterRVAdapter adapter = new FilterRVAdapter(mPresenter.getItems(), this);
        rv.setLayoutManager(new LinearLayoutManager(getContext(), LinearLayoutManager.HORIZONTAL, false));
        rv.setAdapter(adapter);
    }

    @Override
    public void onItemClick(File file) {
        getCallback().onFilterSelected(file);
    }

    @Override
    public void onProgress(float progress) {

    }

    @Override
    public void onClose() {
        ((FilterRVAdapter) rv.getAdapter()).setSelect(0);
    }
}
